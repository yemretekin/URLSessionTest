//
//  ViewController.swift
//  URLSessionTest
//
//  Created by Emre Tekin on 23.06.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    @IBAction func buttonClicked(_ sender: Any) {
        
        let url = URL (string: "https://api.kanye.rest/")!
        let task = URLSession.shared.dataTask(with: url) { (data: Data? , response: URLResponse?, error: Error?) in
            
            if let error = error {
                print("Error", error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("not the right response")
                return
            }
            guard (200...299).contains(httpResponse.statusCode) else {
                print("Error, status code", httpResponse.statusCode)
                return
            }
            guard let data = data else {
                print("bad data")
                return
            }
            
            do {
                
            let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String:String]
            DispatchQueue.main.async {
                self.label.text = json["quote"]
            }
            }catch let error{
                    print("Error", error)
                }
            
            }
        task.resume()
    }
    
}

