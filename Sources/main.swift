import Vapor
import Foundation
import HTTP
import JSON
import Jay

let drop = Droplet()

drop.get { req in
    return "Hello, World!"
}

drop.post("search-giphy") { req in
    Logger.info("env: " + (ProcessInfo.processInfo.environment["REDIS_URL"] ?? "no env var"))
    
    guard let query = req.data["text"]?.string?
        .replacingOccurrences(of: " ", with: "+") else {
        return Response(status: .badRequest)
    }
    
    return try Response.async { portal in
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let url = URL(string: "http://api.giphy.com/v1/gifs/search?q=\(query)&api_key=dc6zaTOxFJmzC&limit=1")!
        session.dataTask(with: url, completionHandler: { data, response, error in
            guard let queryResponseData = data, let queryResponseBytes = try? queryResponseData.makeBytes() else {
                portal.close(with: Response(status: .internalServerError))
                return
            }
            
            do {
                let giphyResponse = try JSON.init(serialized: queryResponseBytes)
                guard let urlArray = giphyResponse["data"]?["images"]?["original"]?["url"]?.array,
                    urlArray.count > 0,
                    let firstGifUrl = urlArray[0].string
                else {
                    portal.close(with: Response(status: .notFound))
                    return
                }
                
                let payload: [String : Any] = [
                    "text": "Here is a \(query) gif",
                    "attachments": [[
                        "image_url": firstGifUrl
                    ]]
                ]
                    
                let data = try Jay(formatting: .prettified).dataFromJson(any: payload)
                portal.close(with: Response(status: .ok, headers: ["Content-Type": "application/json"], body: data))
                
            } catch {
                portal.close(with: Response(status: .internalServerError))
            }
            
            portal.close(with: Response(status: .notFound))
            
        }).resume()
    }
}

enum Vote: String {
    case up = "+"
    case down = "-"
}

drop.post("vote-giphy") { req in
    Logger.info("env: " + (ProcessInfo.processInfo.environment["REDIS_URL"] ?? "no env var"))
    
    guard let text = req.data["text"]?.string, let vote = Vote(rawValue: text) else {
        return Response(status: .badRequest)
    }
    
    let payload: [String : Any] = [
        "text": vote.rawValue
    ]
    
    let data = try Jay(formatting: .prettified).dataFromJson(any: payload)
    return Response(status: .ok, body: data)

}

drop.run()
