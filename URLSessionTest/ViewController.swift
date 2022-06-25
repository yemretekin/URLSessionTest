//
//  ViewController.swift
//  URLSessionTest
//
//  Created by Emre Tekin on 23.06.2022.
//

import UIKit

class ViewController: UIViewController {

    var networker = Networker()

    @IBOutlet weak var label: UILabel!

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()


    }

    @IBAction func buttonClicked(_ sender: Any) {
        networker.getQuote { Kanye, Error in
            if let Error = Error {
                self.label.text = "Error"
                return
            }
            self.label.text = Kanye?.quote
        
            
            
        }

    }
    @IBAction func imageClicked(_ sender: Any) {
        networker.getImage { Data, Error in
            if let Error = Error {
                print("Error")
                return
            }
            self.imageView.image = UIImage(data: Data!)
        }
            
    }
    
}
