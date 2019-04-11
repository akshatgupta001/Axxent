//
//  CreateProductVC.swift
//  Axent
//
//  Created by Akshat Gupta on 08/04/19.
//  Copyright © 2019 coded. All rights reserved.
//

import UIKit

class CreateProductVC: BaseViewController , UIPickerViewDelegate, UIPickerViewDataSource{
    
    var productName : String = ""
    var productDescription : String = ""
    @IBOutlet weak var descriptionTextField: UITextView!
    @IBOutlet weak var nameTextField: UITextField!
    
    let types : [String] = ["Loan", "Other Investments"," Fixed Income Tbills", "Fixed Income E-bond", "Equity"]
    var productType : String = "0"
    
    @IBOutlet weak var pickerView: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSlideMenuButton()
        self.title = "Create Product"
        pickerView.delegate = self
        pickerView.dataSource = self
        hideKeyboard()
        
        //listenet for keyboard hide and show
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        // Do any additional setup after loading the view.
    }
    
    
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return types.count
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return types[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        productType = String(row)
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                if descriptionTextField.isFirstResponder{
                  self.view.frame.origin.y -= keyboardSize.height
                }
                
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
        self.productName = nameTextField.text ?? " "
       self.productDescription = descriptionTextField.text
        
    }
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        //        self.view.resignFirstResponder()
        self.view.endEditing(true)
    }

    @IBAction func createProduct(_ sender: Any) {
        print(productName)
        print(productType)
        print(productDescription)
    }
}
