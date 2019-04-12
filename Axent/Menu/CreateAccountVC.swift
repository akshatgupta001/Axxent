//
//  CreateAccountVC.swift
//  Axent
//
//  Created by Akshat Gupta on 08/04/19.
//  Copyright © 2019 coded. All rights reserved.
//

import UIKit

class CreateAccountVC: BaseViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var clientIdTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    var name : String = ""
    var clientId : String = ""
    var email : String = ""
    var phone : String = ""
    var username : String = ""
    var password : String = ""
    var type : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSlideMenuButton()
        self.title = "Create Account"
        hideKeyboard()
        // Do any additional setup after loading the view.
    }
    

    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        //        self.view.resignFirstResponder()
        self.view.endEditing(true)
    }

    @IBAction func createAccount(_ sender: Any) {
        
            name = nameTextField.text!
            clientId = clientIdTextField.text!
            phone = phoneTextField.text!
            username = usernameTextField.text!
            email = emailTextField.text!
            password = passwordTextField.text!
        
        if name == "" || clientId == "" || email == ""{
            let alert = UIAlertController(title: "Alert", message: "Fields can't be left empty", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                switch action.style{
                case .default:
                    print("default")
                    
                case .cancel:
                    print("cancel")
                    
                case .destructive:
                    print("destructive")
                    
                    
                }}))
            self.present(alert, animated: true, completion: nil)
        }
            
        print(name)
        print(email)
        
    }
}
