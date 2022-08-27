//
//  LoginViewController.swift
//  ToDoFIRE
//
//  Created by Nikolai Maksimov on 26.08.2022.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    
    @IBOutlet var warnLabel: UILabel!
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(kbDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbDidHide), name: UIResponder.keyboardDidHideNotification, object: nil)
        
    }
    
    @objc func kbDidShow(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        
        // размер клавиатуры
        let kbFrameSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        // высота клавиатуры
        (self.view as! UIScrollView).contentSize = CGSize(
            width: self.view.bounds.width,
            height: self.view.bounds.height + kbFrameSize.height
        )
        
        (self.view as! UIScrollView).scrollIndicatorInsets = UIEdgeInsets(
            top: 0,
            left: 0,
            bottom: kbFrameSize.height,
            right: 0
        )
        
    }
    
    @objc func kbDidHide() {
        (self.view as! UIScrollView).contentSize = CGSize(
            width: self.view.bounds.width,
            height: self.view.bounds.height
        )
    }

    @IBAction func loginButtonPressed(_ sender: UIButton) {
        
    }
    
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        
    }
    
    

}

