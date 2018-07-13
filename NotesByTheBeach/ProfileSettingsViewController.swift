//
//  ProfileSettingsViewController.swift
//  NotesByTheBeach
//
//  Created by Xcode Server on 10/6/18.
//  Copyright © 2018 bklv. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit
import FirebaseAuth
import FirebaseAuthUI


class ProfileSettingsViewController: UIViewController {

    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var genderLabel: UILabel!
    @IBOutlet var dobLabel: UILabel!
    @IBOutlet var phoneLabel: UILabel!
    
    @IBOutlet var logoutButton: UIButton!
    
    var users = [User]()
    
    var name: String = ""
    var email: String = ""
    var providerPassword: String = ""
    var usernameEmail: String = ""
    var usernameFb: String = ""
    
    var userfbID: String = ""
    var accountType: String = ""
    
    var emailAcctId: String = ""
    var fbAcctId: String = ""
    
    var emailprovider = [EmailAuthProvider]()
    var facebookprovider = [FacebookAuthProvider]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false

//        guard let username = Auth.auth().currentUser?.displayName else { return }
//        guard let email = Auth.auth().currentUser?.email else { return }
//        guard let providerData = Auth.auth().currentUser?.providerData else { return }
//        guard let providerID = Auth.auth().currentUser?.providerID else { return }
//        guard let uid = Auth.auth().currentUser?.uid else { return }
//
//        print(email)
//        print(providerData)
//        print(providerID)
//        print(uid)
        

//        if let providerData = Auth.auth().currentUser?.providerData {
//            for userInfo in providerData {
//
//                if userInfo.providerID == "password" {
//
//                    let emailProvider = userInfo.providerID
//                    print(emailProvider)
//
//                }
//            }
//        }
        
//        let auth = Auth.auth()
//        let emailprovider = auth.currentUser
//        let emailuid = emailprovider!.uid
//
//        print(emailuid)
        
         let emailprovider = [EmailAuthProvider]()
         let credential = EmailAuthProvider.credential(withEmail: email, password: providerPassword)
         let currentUser = EmailAuthProvider.self
        
         let user = Auth.auth().currentUser
        
         print ("currentUser")
        
         user?.linkAndRetrieveData(with: credential) { (authResult, error) in
            if let error = error {
                // ...
                return
            }
            print(authResult!)
           }
        
        
        if let providerData = Auth.auth().currentUser?.providerData {
            for userInfo in providerData {

                    let currentProviderID = userInfo.providerID
                    let currentProviderEmail = userInfo.email
                    let currentProviderUID = userInfo.uid
                    let currentProviderDisplayname = userInfo.displayName


                    print("user is signed in with fblalal\(currentProviderID)")
                    print("user is signed in with fblalal\(currentProviderEmail)")
                    print("user is signed in with fblalal\(currentProviderUID)")
                    print("user is signed in with fblalal\(currentProviderDisplayname)")

                    usernameLabel.text = "notes by \(currentProviderDisplayname)"
                    emailLabel.text = currentProviderEmail
                
                let user = Auth.auth().currentUser
                
                if let user = user {
                    
                    let uid = user.uid
                    
                    print (uid)
                }
                
                

        }}
    
        
        
//      let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
//      let credential = EmailAuthProvider.credential(withEmail: email!, password: password!)
    
        
//        if let providerData = Auth.auth().currentUser?.providerData {
//            for userInfo in providerData {
//                switch userInfo.providerID {
//                case "facebook.com":
//                    print("user is signed in with fb\(userInfo.providerID)")
//                case "password":
//                    print("user is signed in with \(userInfo.providerID)")
//                default:
//                    print("user is signed in with \(userInfo.providerID)")
//                }
//            }
//        }
    
    
    //  let prevUser = Auth.auth().currentUser?.providerData
        
//        let user = Auth.auth().currentUser
//
//                if let user = user {
//
//                    let ref = Database.database().reference()
//
//                    ref.child("users").child(user.uid).observe(.value) { snapshot in
//
//                        print(snapshot)
//
//                        for child in snapshot.children {
//                            let userSnapshot = child as! DataSnapshot
//                            let users = User(snapshot: userSnapshot)
//                        }
//                        print ("error")
//
//                        }
//              }
    
    
//    let user = Auth.auth().currentUser
//    let prevUser = Auth.auth().currentUser?.providerData
        
    
        ////lalalalalal
//        let auth = Auth.auth()
//        print(auth)
//        let provider = auth.currentUser?.providerID
//        let providerDe = auth.currentUser?.email
//        let providerFe = auth.currentUser?.providerID
//
//        print(provider)
//        print(providerDe)
        

        // Merge prevUser and currentUser accounts and data
        
    //      self.observeData()
   //     self.printEmailId()
//        self.printFBId()

    }

    
    @IBAction func logoutDidTapped(_ sender: Any) {
        
        
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            
            }
        
           let vc = storyboard?.instantiateViewController(withIdentifier: "SignInDirectViewController")
           self.navigationController?.pushViewController(vc!, animated: true)
            print("Did log out of facebook")
    }
    
    func printFBId() {
        
        // providerData is UID...
        
        if let providerData = Auth.auth().currentUser?.providerData {
            for userInfo in providerData {
                switch userInfo.providerID {
                case "fb.com":
                    print("user is signed in with fb\(userInfo.providerID)")
                default:
                    print("user is signed in with \(userInfo.providerID)")
                }
            }
        }
        
    }
    
    func printEmailId() {
        
        //providerData = UID...
        
        if let providerData = Auth.auth().currentUser?.providerData {
            for userInfo in providerData {
                
                if userInfo.providerID == "password" {
                    
                    let emailProvider = userInfo.providerID
                    print(emailProvider)
                    
                }
            }
        }
    
    }
    
    
    func printEmailDetails() {
        
        let user = Auth.auth().currentUser!
        
        let emailcredential = EmailAuthProvider.credential(withEmail: email, password: providerPassword)
        Auth.auth().currentUser!.linkAndRetrieveData(with: emailcredential) { (authResult, error) in
            
            if let error = error {
                
                return
            }
            print(emailcredential)
            print(authResult!)
        }
    }
    
    func observeData() {
        
        
//        if let providerData = Auth.auth().currentUser?.providerData {
//            for userInfo in providerData {
//
//                let prevUser = Auth.auth().currentUser?.providerData
//
//                if let prevUser = prevUser {
//
//                    let ref = Database.database().reference()
//                    ref.child("users").observe(.value) { snapshot in
//
//                        print(self.emailAcctId)
//                        print(snapshot)
//
//                        for child in snapshot.children {
//                            let noteSnapshot = child as! DataSnapshot
//                            let user = User(snapshot: noteSnapshot)
//                        }
//                        print ("error")
//                        }
//                   }
//
//                 }
//        }}
        
   }
}


