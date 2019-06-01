//
//  SignUpViewController.swift
//  HeadHunters
//
//  Created by Alumnos on 6/1/19.
//  Copyright © 2019 CoCuyApps. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func signUpAction(_ sender: AnyObject) {
        if passwordTextField.text == "" && emailTextField.text == ""{
            print("esta vacio")
        }
        else{
            print("no esta vacio")
            print(emailTextField.text!)
            print(passwordTextField.text!)
            
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!){ (user, error) in
                if error == nil {
                    print("sin errores")
                    if let level0 = self.storyboard!.instantiateViewController(withIdentifier: "LogIn") as? UIViewController{
                        self.present(level0, animated: true, completion: nil)
                    }
                }
                else{
                    print("con errores")
                    print(error?.localizedDescription ?? "firebase ta cagado")
                    
                }
            }
        }
    }
    
}
