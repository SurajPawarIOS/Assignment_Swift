//
//  SecondViewController.swift
//  Assignment_Swift
//
//  Created by Suraj Pawar on 04/06/18.
//  Copyright © 2018 Suraj Pawar. All rights reserved.
//

import UIKit
import SDWebImage

class SecondViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var secondImageView: UIImageView!
    
    // MARK: Variables
    var imageURL:String = ""
    
    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
       secondImageView.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "placeholder.png"))
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }

    @IBAction func backAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: false)
    }
    
    
}
