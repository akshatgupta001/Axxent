//
//  ProductListVC.swift
//  Axent
//
//  Created by Akshat Gupta on 08/04/19.
//  Copyright © 2019 coded. All rights reserved.
//

import UIKit

class ProductListVC: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    var fields : [[String]] = [[],[],[],[],[]]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSlideMenuButton()
        self.title = "Product list"
        tableView.dataSource = self
        tableView.delegate = self
        getData()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func segementChanged(_ sender: Any) {
        tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        //select segment
        cell.textLabel?.text = fields[segmentControl.selectedSegmentIndex][indexPath.row]
        return cell 
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fields[segmentControl.selectedSegmentIndex].count
    }

    func getData(){
        let url = URL(string: "http://axxentcapital.com/loan/files/pages/app/fetchtable.php")!
        let req = NSMutableURLRequest(url: url)
        let request:URLRequest
        req.httpMethod = "GET"
        req.addValue("Keep-Alive", forHTTPHeaderField: "Connection")
        // req.setValue("application/json", forHTTPHeaderField: "Accept")
        //let configuration = URLSessionConfiguration.default
        request = req as URLRequest
        
        URLSession.shared.dataTask(with: request) { (data, response, err) -> Void  in
            
            
            if(err == nil){
                do{
                    let data: Data = data! // received from a network request, for example
                    let json = try? JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
                    var i = 0
                    if let users = json?["product"] as? [Any]{
                        for user in users{
                            i = i+1
                            if let user = user as? [String:String]{
                                let t = Int(user["type"] ?? "0")
                                
                                let name = user["name"]
                                if t!>=0 && t! < 5 {
                                    self.fields[t!].append(name!)
                                }
                                
                                
                              
                                // self.fields.append(record as! [String])
                                
                                
                            }
                        }//end of for user
                        print(self.fields.count)
                        
                        DispatchQueue.global().async { [weak self] in
                            DispatchQueue.main.async {
                                
                               self?.tableView.reloadData()
                                
                            }
                        }
                        
                    }//end of if let user
                    
                }
                catch{
                    print("captcha error: \(err.debugDescription)")
                }
            }else{
                print("data not found error : \(err.debugDescription)")
            }
            }.resume()
        
    }


}
