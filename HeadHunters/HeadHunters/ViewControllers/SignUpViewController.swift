 //
//  SignUpViewController.swift
//  HeadHunters
//
//  Created by Alumnos on 6/4/19.
//  Copyright © 2019 CoCuyApps. All rights reserved.
//

import UIKit
import Firebase


class SignUpViewController: UIViewController{
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var ref: DatabaseReference!
    override func viewDidLoad() {
        passwordTextField.isSecureTextEntry = true
        ref = Database.database().reference()
    }

    
    @IBAction func signUpAction(_ sender: AnyObject) {
        //Loading animation starts
        self.activityIndicator.startAnimating()
        if passwordTextField.text == "" && emailTextField.text == ""{
            print("esta vacio")
            //Loading animation stops
            self.activityIndicator.stopAnimating()
        }
        else{
            print("no esta vacio")
            print(emailTextField.text!)
            print(passwordTextField.text!)
            
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!){ (user, error) in
                if error == nil { self.ref.child("User").child(Auth.auth().currentUser!.uid).setValue(["UserName": self.nameTextField.text])
                    print("sin errores")
                    if let level0 = self.storyboard!.instantiateViewController(withIdentifier: "LogIn") as? UIViewController{
                        self.present(level0, animated: true, completion: nil)
                        //Loading animation stops
                        self.activityIndicator.stopAnimating()
                    }
                }
                else{
                    print("con errores")
                    print(error?.localizedDescription ?? "firebase ta cagado")
                    //Loading animation stops
                    self.activityIndicator.stopAnimating()
                }
            }
        }
    }
}
