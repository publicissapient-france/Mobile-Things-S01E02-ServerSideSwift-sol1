import Vapor
import Foundation
import HTTP
import JSON
import Jay

// 105811633521.130591365587 client ID
// 2eafe0d6e3d37295451529bc1648bf7c secret
// n4XlNmMZpjXzP9clhkvfRByT Verification token

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
            
            let r = try! JSON.init(serialized: queryResponseBytes)
            
            if let urlArray = r["data"]?["images"]?["original"]?["url"]?.array,
                urlArray.count > 0,
                let string = urlArray[0].string {
                
                let payload: [String : Any] = [
                    "text": string,
                    "attachment": [
                        "text": "a"
                    ]
                ]
                
                do {
                    let data = try Jay(formatting: .prettified).dataFromJson(any: payload)
                    portal.close(with: Response(status: .ok, body: data))
                } catch {
                    portal.close(with: Response(status: .internalServerError))
                }

            }
            portal.close(with: Response(status: .notFound))
            
        }).resume()
    }

}

drop.run()
