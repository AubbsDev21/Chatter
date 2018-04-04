//
//  LoginViewController.swift
//  Chatter
//
//  Created by Aubre Body on 3/13/18.
//  Copyright © 2018 Aubre Body. All rights reserved.
//

import UIKit
import FirebaseAuth
import GoogleSignIn
class LoginViewController: UIViewController {
  
    @IBOutlet weak var ChatterLabel: UILabel!
    @IBOutlet weak var LoginButton2: UIButton!
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
    }
    

    
    var idenfier = "LoginSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        LoginSetup()
        
        // Do any additional setup after loading the view.
    }

    
  
   
    
    
   ////////////Op Function /////////////////
    @IBAction func LoginButton(_ sender: Any) {
        regSigninbutton()
    }
    
    func regSigninbutton() {
        Auth.auth().signInAnonymously { (User, Error) in
            
            if Error != nil {
                print(Error?.localizedDescription)
                return
            }
          
        }
       performSegue(withIdentifier: "Navsegue", sender: nil)
    }
    
    func LoginSetup(){
        ChatterLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        ChatterLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 155).isActive = true
        ChatterLabel.widthAnchor.constraint(equalToConstant: 193).isActive = true
        ChatterLabel.heightAnchor.constraint(equalToConstant: 89).isActive = true
        
        LoginButton2.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        LoginButton2.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 193).isActive = true
        LoginButton2.widthAnchor.constraint(equalToConstant: 291).isActive = true
        LoginButton2.heightAnchor.constraint(equalToConstant: 40).isActive = true
        LoginButton2.layer.cornerRadius = 8
    }
    
    
}
