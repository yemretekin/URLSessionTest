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
    
    static let shared = Networker()
    
    private let session: URLSession
    
    init() {
        let config = URLSessionConfiguration.default
        session = URLSession(configuration: config)
    }
    
    func getQuote (completion: @escaping (Kanye?,Error?) -> (Void)) {
        
        let url = URL (string: "https://api.kanye.rest/")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
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
        
        }
        task.resume()
}
    func getImage(completion: @escaping (Data?,Error?) -> (Void)) {
        
        let url = URL (string: "https://picsum.photos/200/300")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = session.downloadTask(with: url){ (localUrl: URL? , response: URLResponse?, error: Error?) in
        
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
        guard let localUrl = localUrl else {
            DispatchQueue.main.async {
                completion(nil,NetworkerError.badData)
            }
            return
        }
        
        do {
            let Data = try Data(contentsOf:localUrl)
        DispatchQueue.main.async {
        completion(Data,nil)
        }
        }catch let error{
                print("Error", error)
            }
        
        }
        task.resume()
    }
}
