//
//  LoginController.swift
//  Japanki
//
//  Created by Hoang Luong on 23/8/20.
//

import UIKit

class LoginController: UIViewController {
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var changeActionButton: UIButton!
    
    var mode: LoginMode = .Register
    
    enum LoginMode: String {
        case Register = "Sign up"
        case Login = "Log in"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func actionButtonClicked(_ sender: Any) {
        guard let email = emailTextfield.text,
            let password = passwordTextfield.text else { return }
        
        if mode == .Login {
            FirebaseService.shared.loginUser(email: email, password: password) { user in
                 if user != nil {
                     self.dismiss(animated: true, completion: nil)
                 }
             }
        } else {
            FirebaseService.shared.createUser(email: email, password: password) { user in
                if user != nil {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func changeActionButtonClicked(_ sender: Any) {
        if mode == .Login {
            actionButton.setTitle("Sign up", for: .normal)
            changeActionButton.setTitle("Register for new account.", for: .normal)
            mode = .Register
        } else {
            actionButton.setTitle("Log in", for: .normal)
            changeActionButton.setTitle("Have an account? Log in.", for: .normal)
            mode = .Login
        }
        
    }
    
}
