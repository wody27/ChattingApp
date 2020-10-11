//
//  LoginViewController.swift
//  ChattingApp
//
//  Created by 이재용 on 2020/10/11.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.borderColor = UIColor.black.cgColor
        emailTextField.layer.cornerRadius = 10
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = UIColor.black.cgColor
        passwordTextField.layer.cornerRadius = 10
        
        emailTextField.addInset()
        passwordTextField.addInset()
        
    }
    
    @IBAction func login(_ sender: UIButton) {
        
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let e = error {
                print(e.localizedDescription)
            } else {
                
                self.performSegue(withIdentifier: "Login", sender: self) 
            }
        }
    }
    
}
