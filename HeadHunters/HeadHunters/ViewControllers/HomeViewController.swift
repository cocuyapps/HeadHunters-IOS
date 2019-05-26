//
//  HomeViewController.swift
//  HeadHunters
//
//  Created by Alumnos on 5/25/19.
//  Copyright © 2019 CoCuyApps. All rights reserved.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func logOutButton(_ sender: UIButton) {
        do
        {
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "logout", sender: self)
        }
        catch
        {
            print("Couldn't log out")
        }
    }
}
