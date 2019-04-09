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
    
   
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSlideMenuButton()
        self.title = "Client List"
        collectionView?.isScrollEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib.init(nibName: "CustomCell", bundle: nil), forCellWithReuseIdentifier: "CustomCell")
        // Do any additional setup after loading the view.
    }
     func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 20
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
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
            cell.titleLabel.text = "section: \(indexPath.section) && row: \(indexPath.row)"
        }
        
        
        return cell
    }
   

}
