//
//  ViewController.swift
//  Axent
//
//  Created by Akshat Gupta on 08/04/19.
//  Copyright © 2019 coded. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {

    var values = [5,6,3,8,0,1]
    @IBOutlet weak var label0: UILabel!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label5: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSlideMenuButton()
        self.title = "Home"
        setValue()
        
        
        
    }
    
    func setValue(){
        self.label0.text = String(self.values[0])
        self.label1.text = String(self.values[1])
        self.label2.text = String(self.values[2])
        self.label3.text = String(self.values[3])
        self.label4.text = String(self.values[4])
        self.label5.text = String(self.values[5])
    }
}

