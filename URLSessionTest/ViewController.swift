//
//  ViewController.swift
//  URLSessionTest
//
//  Created by Emre Tekin on 23.06.2022.
//

import UIKit

class ViewController: UIViewController {
    
    let networker = Networker()
    
    @IBOutlet weak var label: UILabel!
    
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
    
}

