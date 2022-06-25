//
//  Networker.swift
//  URLSessionTest
//
//  Created by Emre Tekin on 25.06.2022.
//

import Foundation

enum NetworkerError: Error {
    
    case badResponse
    case badStatusCode(Int)
    case badData
}

class Networker {
    
    func getQuote (completion: @escaping (Kanye?,Error?) -> (Void)) {
    let url = URL (string: "https://api.kanye.rest/")!
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: url) { (data: Data? , response: URLResponse?, error: Error?) in
        
        if let error = error {
            DispatchQueue.main.async {
                completion(nil,error)
            }
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            DispatchQueue.main.async {
                completion(nil,NetworkerError.badResponse)
            }
            return
        }
        guard (200...299).contains(httpResponse.statusCode) else {
            DispatchQueue.main.async {
                completion(nil,NetworkerError.badStatusCode(httpResponse.statusCode))
            }
            return
        }
        guard let data = data else {
            DispatchQueue.main.async {
                completion(nil,NetworkerError.badData)
            }
            return
        }
        
        do {
            
            let kanye = try! JSONDecoder().decode(Kanye.self, from: data)
        DispatchQueue.main.async {
        completion(kanye,nil)
        }
        }catch let error{
                print("Error", error)
            }
        
        }.resume()
}
}
