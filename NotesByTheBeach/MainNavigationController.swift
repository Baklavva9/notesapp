//
//  MainNavigationController.swift
//  NotesByTheBeach
//
//  Created by Xcode Server on 4/7/18.
//  Copyright © 2018 bklv. All rights reserved.
//

import UIKit
import Firebase

class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        
        let user = Auth.auth().currentUser
        
        if isLoggedIn() {
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "NotesTableViewController")
            self.navigationController?.pushViewController(vc!, animated: true)
            
        } else {
            
            perform(#selector(showSignUpViewController), with: nil, afterDelay: 0.01)
        
        }
    }
    
    @objc func isLoggedIn() -> Bool {
        
        let user = Auth.auth().currentUser
        return true
    }

    @objc func showSignUpViewController() {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "SignUpViewController")
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
}
