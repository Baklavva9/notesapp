//
//  LoginEmailViewController.swift
//  NotesByTheBeach
//
//  Created by Xcode Server on 9/6/18.
//  Copyright © 2018 bklv. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseAuthUI
import FBSDKLoginKit

class SignInDirectViewController: UIViewController {
   
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    @IBOutlet var loginviewbtn: UIButton!
    @IBOutlet var signupviewbtn: UIButton!
    
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var fbloginButton: UIButton!
    
    var notes = [Note]()
    var note: Note!
    
    var users = [User]()
    
    var textNotes: String = ""
    var category: String = ""
    var expense: String = ""
    var byUser: String = ""
    var noteId: String = ""
    
    var emailAcctId: String = ""
    var fbAcctId: String = ""
    var auth: String = ""
    
    var name: String = ""
    var email: String = ""
    var providerPassword: String = ""
    var usernameEmail: String = ""
    var usernameFb: String = ""
    
    var userfbID: String = ""
    var accountType: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        
        
//        Auth.auth().addStateDidChangeListener { auth, user in
//            if user != nil {
//                print ("user is not signed in")
//            } else {
//                print ("user is signed in")
//            }}
        
        Auth.auth().addStateDidChangeListener { auth, user in
            if user != user {
                
                let user = Auth.auth().currentUser
                print ("user is signed in")
            } else {
                 print ("user is not signed in")
            }}
    }
    
    
    //LOGIN WITH EMAIL
    
    @IBAction func onLoginTapped(_ sender: Any) {
        
//      guard let email = emailTextField.text else { return }
//      guard let password = passwordTextField.text else { return }
        
   //   let user = Auth.auth().currentUser
   //   let prevUser = Auth.auth().currentUser
        
        let email = emailTextField.text
        let providerPassword = passwordTextField.text
        
        if emailTextField.text == "" || passwordTextField.text == ""  {
            
            let alertController = UIAlertController(title: "Oops", message: "We can't proceed because one of the fields is blank. Please note that all fields are required.", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
            
            return
            
        }
        
    
        
        //// if email is 1st login, add fb as a second provider
        
        let credential = EmailAuthProvider.credential(withEmail: email!, password: providerPassword!)

        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            if let error = error {

                return

            } else {
                
                let fbcredential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                
                let user = Auth.auth().currentUser

                user?.linkAndRetrieveData(with: fbcredential) { (authResult, error) in

                    if let error = error {

                        return
                    }
                    print(fbcredential)
                    }
            }
        }
        
        
         //// if 1st login is a fb account, add email as a second provider...
        
        let fbcredential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString!)
        Auth.auth().signInAndRetrieveData(with: fbcredential) { (authResult, error) in
            if let error = error {

                return

            } else {

                let credential = EmailAuthProvider.credential(withEmail: email!, password: providerPassword!)

                let user = Auth.auth().currentUser
                user?.linkAndRetrieveData(with: credential) { (authResult, error) in

                    if let error = error {

                        return
                    }
                    print(credential)

                }
            }}
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "NotesTableViewController")
        self.navigationController?.pushViewController(vc!, animated: true)
    
    }

    //LOGIN WITH FACEBOOK
    
    @IBAction func fbloginDidTapped(_ sender: Any) {
        
        
        
            FBSDKLoginManager().logIn(withReadPermissions: ["email", "public_profile"], from: self) {
                (result, err)  in
                
                if err != nil {
                    print("Custom FB Login failed:", err ?? "")
                    return
                } else {
                    print ("fb permission given")
    
            
          //
                
            let user = Auth.auth().currentUser
                
            let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString!)

            Auth.auth().signIn(with: credential, completion: { (user, error) in

                if let error = error {

                    return

                }
                    print("facebook login is linked with\(user)")
                
                

        //linking other accounts when sign in w fb, email account is link below

                let emcredential = EmailAuthProvider.credential(withEmail: self.email, password: self.providerPassword)

                let user = Auth.auth().currentUser
                user?.linkAndRetrieveData(with: emcredential) { (authResult, error) in

                    if let error = error {

                        return
                    }
                        print("facebool login is linked with email\(user)")
                    }


                })
        
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "NotesTableViewController")
                self.navigationController?.pushViewController(vc!, animated: true)
                
         //     self.createFbAccount()
                }
                }
    }
    
    //facebook graph request for console log
    
    // facebook login modalities //
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        if error != nil {
            
    //        let loggedinuser = Auth.auth().currentUser?.uid
            
            print(error)
            return
           
        }
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Did log out of facebook")
    }

    func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }

    func fetchProfile() {
    
    FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, email, picture.type(large)"]).start {
        (connection, result, err) in
        
        if err != nil {
            
            print("Failed to start graph request:", err ?? "")
           
            return
        }
      }
    }
    
    
    func createFbAccount() {
        
//        let accessToken = FBSDKAccessToken.current()
//        let userfbID = FBSDKAccessToken.current().userID
//        guard let accessTokenString = accessToken?.tokenString else { return }
//
//        let credential = FacebookAuthProvider.credential(withAccessToken: accessTokenString)
//        Auth.auth().signIn(with: credential, completion: { (user, error) in
//
//            let user = Auth.auth().currentUser
//
//            if let user = user {
//                let uid = user.uid
//                let email = user.email
//                let name = user.displayName
//                let fbID = FBSDKAccessToken.current().userID
//
//                print(uid)
//                print(email)
//
//                let user = Auth.auth().currentUser
//                let ref = Database.database().reference()
//
//                let newUser: [String: Any] = [ "email"         :   email,
//                                               "username"      :   name,
//                                               "userfbID"      :   fbID,
//                                               "userAccountId" :   "\(user!.uid)",
//                    //                                              "accountType"   :   "facebook",
//                    //                                              "createdOn"     :   Date(),
//                ]
//
//
//                ref.child("users").child(user!.uid).childByAutoId().setValue(newUser)
//
//                print("successfully logged in with our users: ", user ?? "")
//
//                return
//
//            }  else {
//
//                print ("error")
//
//            }
//
//        })
        
    }
    

    @objc func isLoggedIn() -> Bool {

        let user = Auth.auth().currentUser
        return true
    }

}

    


