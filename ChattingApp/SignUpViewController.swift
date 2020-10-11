//
//  SignUpViewController.swift
//  ChattingApp
//
//  Created by 이재용 on 2020/10/11.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    
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
    
    @IBAction func signup(_ sender: UIButton) {
        
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let e = error {
                print(e)
            } else {
                self.performSegue(withIdentifier: "SignUp", sender: self)
            }
        }
        
    }
    
}
