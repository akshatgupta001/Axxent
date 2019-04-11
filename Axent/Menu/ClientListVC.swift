//
//  ClientListVC.swift
//  Axent
//
//  Created by Akshat Gupta on 08/04/19.
//  Copyright © 2019 coded. All rights reserved.
//

import UIKit
private let reuseIdentifier = "CustomCell"

class ClientListVC: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let headings = ["Client Id", "Name", "Email", "Username", "Phone"]
    var fields : [[String]] = [["a","b","c","d","e"],["a","b","c","d","e"]]
    
   
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    override func viewDidLoad() {
    //
        let temp = ["","","","",""]
        for _ in 0...20{
          fields.append(temp)
            
        }
            
            
        super.viewDidLoad()
        self.addSlideMenuButton()
        self.title = "Client List"
        collectionView?.isScrollEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib.init(nibName: "CustomCell", bundle: nil), forCellWithReuseIdentifier: "CustomCell")
        getData()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        var indexPaths: [NSIndexPath] = []
        for i in 0..<collectionView!.numberOfItems(inSection: 1) {
            indexPaths.append(NSIndexPath(item: i, section: 1))
        }
        collectionView?.reloadItems(at: indexPaths as [IndexPath])
    }
    
     func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return fields.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fields[0].count
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CustomCell
        
        if indexPath.section == 0 {
            cell.backgroundColor = UIColor.darkGray
            cell.titleLabel.textColor = UIColor.white
            
            
        } else {
            cell.backgroundColor = UIColor.white
            cell.titleLabel.textColor = UIColor.black
        }
        if indexPath.section == 0 {
            cell.titleLabel.text = headings[indexPath.row]
        }else{
            
                cell.titleLabel.text = String(indexPath.section)
            if(fields.count>20){
                cell.titleLabel.text = fields[indexPath.section][indexPath.row]
            }
            if indexPath.section%2 == 0{
                cell.backgroundColor = UIColor.lightGray
            }
            
        }
        
        
        
        return cell
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
                    if let users = json?["login_user"] as? [Any]{
                        for user in users{
                            i = i+1
                            if let user = user as? [String:String]{
                                let clientid = user["client_num"]
                                let name = user["name"]
                                let email = user["email"]
                                let username = user["username"]
                                let phone = user["phone"]
                                let record  = [clientid,name,email, username, phone]
                                print(record)
                                self.fields[i][0] = clientid!
                                self.fields[i][1] = name!
                                self.fields[i][2] = email!
                                self.fields[i][3] = username!
                                self.fields[i][4] = phone!
                               // self.fields.append(record as! [String])
                               
                                
                            }
                        }//end of for user
                        print(self.fields.count)
                        
                        DispatchQueue.global().async { [weak self] in
                            DispatchQueue.main.async {

                              self?.collectionView.reloadData()
                                let range = Range(uncheckedBounds: (0, self!.collectionView.numberOfSections))
                                let indexSet = IndexSet(integersIn: range)
                                self!.collectionView.reloadSections(indexSet)
                                self?.collectionView.reloadData()
                              
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
