//
//  ProfileViewController.swift
//  HeadHunters
//
//  Created by Alumnos on 6/18/19.
//  Copyright © 2019 CoCuyApps. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController{
    @IBOutlet weak var bandNameTextField: UITextField!
    @IBOutlet weak var bandMembersTextField: UITextField!
    @IBOutlet weak var bandDescriptionTextField: UITextField!
    @IBOutlet weak var bandImageUrlTextField: UITextField!
    @IBOutlet weak var linkMusicTextField: UITextField!
    
    var ref: DatabaseReference!
    override func viewDidLoad() {
        ref = Database.database().reference()
    }
    
    
    @IBAction func saveButton(_ sender: AnyObject) {
        let bandDescription = bandNameTextField.text!
        let bandImgUrl = bandImageUrlTextField.text!
        let bandMembers = bandMembersTextField.text!
        let linkMusic = linkMusicTextField.text!
        let bandName = bandNameTextField.text!
        
        if(bandDescription != "" && bandImgUrl != "" && bandMembers != "" && bandName != "" && bandDescription != ""){
            let userID : String = (Auth.auth().currentUser?.uid)!
            
            let userDB = self.ref.child("User").child(userID)
            userDB.child("BandDescription").setValue(bandDescription)
            userDB.child("BandImgUrl").setValue(bandImgUrl)
            userDB.child("BandMembers").setValue(bandMembers)
            userDB.child("BandName").setValue(bandName)
            userDB.child("BandSample").setValue(linkMusic)
            print("registro")

        }else{
            print("Ingresa todos los campos")
        }
        
    }
    
    
}
