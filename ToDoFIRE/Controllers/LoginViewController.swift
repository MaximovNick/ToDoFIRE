//
//  LoginViewController.swift
//  ToDoFIRE
//
//  Created by Nikolai Maksimov on 26.08.2022.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    let segueIdentifier = "tasksSegue"
    var ref: DatabaseReference!
    
    @IBOutlet var warnLabel: UILabel!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference(withPath: "users")
        
        NotificationCenter.default.addObserver(
            self, selector: #selector(kbDidShow),
            name: UIResponder.keyboardDidShowNotification, object: nil
        )
        
        NotificationCenter.default.addObserver(
            self, selector: #selector(kbDidHide),
            name: UIResponder.keyboardDidHideNotification, object: nil
        )
        
        warnLabel.alpha = 0
        
        Auth.auth().addStateDidChangeListener ({ [weak self] (auth, user) in
            if user != nil {
                self?.performSegue(withIdentifier: self!.segueIdentifier, sender: nil)
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emailTextField.text = ""
        passwordTextField.text = ""
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
    
    func displayWarningLabel(withText text : String) {
        warnLabel.text = text
        
        UIView.animate(withDuration: 3, delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 1,
                       options: [.curveEaseInOut],
                       animations: { [weak self] in
            self?.warnLabel.alpha = 1
        }) { [weak self] complete in
            self?.warnLabel.alpha = 0
        }
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
              email != "", password != "" else {
            displayWarningLabel(withText: "Info is incorrect")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self] (user, error) in
            if error != nil {
                self?.displayWarningLabel(withText: "Error occured")
                return
            }
            
            if user != nil {
                self?.performSegue(withIdentifier: self!.segueIdentifier, sender: nil)
                return
            }
            self?.displayWarningLabel(withText: "No such user")
        })
    }
    
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
              email != "", password != "" else {
            displayWarningLabel(withText: "Info is incorrect")
            
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password, completion: { [weak self] (authResult, error) in
        
            guard error == nil, let user = authResult?.user else {
                
                print(error!.localizedDescription)
                return
            }
            
            let userRef = self?.ref.child(user.uid)
            userRef?.setValue(user.email, forKey: "email")
           
        })
    }
}





