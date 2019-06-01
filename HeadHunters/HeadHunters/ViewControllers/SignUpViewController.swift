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
        if passwordTextField.text == nil {
            print("esta vacio")
            let alertController = UIAlertController(title: "Please introduce a password", message: "Please introduce a password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else{
            print("no esta vacio")
            print(emailTextField.text!)
            print(passwordTextField.text!)
            
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!){ (user, error) in
                if error == nil {
                    print("sin errores")
                    self.performSegue(withIdentifier: "GoHome", sender: self)
                }
                else{
                    print("con errores")
                    print(error?.localizedDescription ?? "firebase ta cagado")
                    
                }
            }
        }
    }
    
}
