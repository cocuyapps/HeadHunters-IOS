//
//  SignUpViewController.swift
//  HeadHunters
//
//  Created by Alumnos on 5/25/19.
//  Copyright © 2019 CoCuyApps. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController{
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func signUpButton(_ sender: UIButton) {
        guard let username = userNameTextField.text else{ return}
        guard let email = userNameTextField.text else{ return}
        guard let pass = userNameTextField.text else{ return}
        
        Auth.auth().createUser(withEmail: email, password: pass) { user, error in
            if user != nil
            {
                print("User created")
                self.performSegue(withIdentifier: "Go to login", sender: self)
            }
            else
            {
                print("error: \(error!.localizedDescription)")
            }
        }
    }
}
