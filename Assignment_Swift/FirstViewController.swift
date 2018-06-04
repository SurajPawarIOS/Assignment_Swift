//
//  ViewController.swift
//  Assignment_Swift
//
//  Created by Suraj Pawar on 04/06/18.
//  Copyright © 2018 Suraj Pawar. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage


class FirstCellViewController: UITableViewCell {
    
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellAgelabel: UILabel!
    @IBOutlet weak var cellUsernamelabel: UILabel!
    @IBOutlet weak var cellTaglinelabel: UILabel!
    
}

class FirstViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    // MARK: Outlets
    @IBOutlet weak var firstTableView: UITableView!
   
    // MARK: Variables
    var wholeArray: NSArray  = []
    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
 
        firstTableView.delegate = self
        firstTableView.dataSource = self
        
        apiCall();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
  
    }
    
    // MARK: API Method
    
    func apiCall() {
        
        let todosEndpoint: String = "http://betaci.abcoeur.com/search.json.php"
        
        Alamofire.request(todosEndpoint, method: .get, encoding: JSONEncoding.default)
            .responseJSON { response in
                

                if let jsonResult = response.result.value {
                 
                    let JSON = jsonResult as! NSDictionary
                    
                    self.wholeArray = JSON["search_result"] as! NSArray
                    
                    DispatchQueue.main.async {
                        
                        self.firstTableView.reloadData()
                        
                    }
                
                }
        }
        
    }
    
    // MARK: Table Dalegates and DataSources
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.wholeArray.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FirstCellIdentifier", for: indexPath) as! FirstCellViewController
        
        let dict:NSDictionary = self.wholeArray[indexPath.row] as! NSDictionary
        
        let pictureURL:String =  (dict["photo_url"] as? String)!
       
        cell.cellImageView.sd_setImage(with: URL(string: pictureURL), placeholderImage: UIImage(named: "placeholder.png"))
        
        cell.cellAgelabel.text = dict["in_age"] as? String
        
        cell.cellTaglinelabel.text = dict["bottomLine"] as? String
        
        cell.cellUsernamelabel.text = dict["in_pseudo"] as? String
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let dict:NSDictionary = self.wholeArray[indexPath.row] as! NSDictionary
        
        let pictureURL:String =  (dict["photo_url"] as? String)!
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "ModuleOne", bundle:nil)
       
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        
        nextViewController.imageURL = pictureURL
        
        self.navigationController?.pushViewController(nextViewController, animated: false)
        
    }
    


}

