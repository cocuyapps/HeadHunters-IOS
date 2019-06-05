//
//  LoginViewController.swift
//  HeadHunters
//
//  Created by Alumnos on 6/4/19.
//  Copyright © 2019 CoCuyApps. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController{
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    
    @IBAction func logInAction(_ sender: AnyObject) {
        
        if passwordTextField.text == "" && emailTextField.text == ""{
            print("esta vacio")
        }
        else{
            print("no esta vacio")
            print(emailTextField.text!)
            print(passwordTextField.text!)
            
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!){ (user, error) in
                if error == nil {
                    print("sin errores")
                    //self.performSegue(withIdentifier: "GoHome", sender: self)
                    if let level2 = self.storyboard!.instantiateViewController(withIdentifier: "Home") as? UITabBarController{
                        self.present(level2, animated: true, completion: nil)
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
