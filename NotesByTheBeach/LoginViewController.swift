//
//  LoginViewController.swift
//  NotesByTheBeach
//
//  Created by Xcode Server on 2/5/18.
//  Copyright © 2018 bklv. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet var loginButton: UIButton!

    @IBAction func loginDidTouch(_ sender: Any?) {

        (sender as! UIButton).alpha = 1.0

        Auth.auth().signInAnonymously { (firUser, error) in
            if error == nil {
                self.performSegue(withIdentifier: "showNotesToday", sender: nil)
            } else {
                print(error?.localizedDescription as Any)
            }
        }

    }
}
