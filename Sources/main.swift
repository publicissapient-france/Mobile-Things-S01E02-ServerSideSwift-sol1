import Vapor
import Foundation
import HTTP
import JSON

let drop = Droplet()

drop.get { req in
    return "Hello, World!"
}

drop.get("search-giphy") { req in
    return try Response.async { portal in
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let url = URL(string: "http://api.giphy.com/v1/gifs/search?q=funny+cat&api_key=dc6zaTOxFJmzC&limit=1")!
        session.dataTask(with: url, completionHandler: { data, response, error in
            guard let queryResponseData = data, let queryResponseBytes = try? queryResponseData.makeBytes() else {
                portal.close(with: Response(status: .internalServerError))
                return
            }
            
            let r = try! JSON.init(serialized: queryResponseBytes)
            
            if let urlArray = r["data"]?["images"]?["original"]?["url"]?.array,
                urlArray.count > 0,
                let string = urlArray[0].string {
                portal.close(with: Response(status: .ok, body: string))
            }
            portal.close(with: Response(status: .notFound))
            
        }).resume()
    }

}

drop.run()
