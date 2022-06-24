//
//  MyViewController.swift
//  URLSessionTest
//
//  Created by Emre Tekin on 23.06.2022.
//

import UIKit

class MyViewController: UIViewController {

    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func button2Clicked(_ sender: Any) {
        
        let url = URL (string: "https://quotable.io/random?tags=love%7Chappiness")!

        let task = URLSession.shared.dataTask(with: url) { (data: Data? , response: URLResponse?, error: Error?) in
            if let error = error {
                print("Error", error)
                return
            }
        do{
            let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
            DispatchQueue.main.async {
                self.label2.text = json["author"] as? String
                self.contentLabel.text = json["content"] as? String
            }
        }
            catch let error{
            print("Error")
        }
        }.resume()
    }
    
}
