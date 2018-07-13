//
//  SignUpViewController.swift
//  NotesByTheBeach
//
//  Created by Xcode Server on 5/6/18.
//  Copyright © 2018 bklv. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FBSDKLoginKit
import FBSDKCoreKit
import FirebaseAuthUI


class SignUpViewController: UIViewController, FBSDKLoginButtonDelegate {

    
//    let authUI = FUIAuth.defaultAuthUI()
//    authUI?.delegate = self
//
//    let providers: [FUIAuthProvider] = [
//        FUIGoogleAuth(),
//        FUIFacebookAuth(),
//        FUITwitterAuth(),
//        FUIPhoneAuth(authUI:FUIAuth.defaultAuthUI()),
//        ]
//    self.authUI.providers = providers

    
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    @IBOutlet var loginviewbtn: UIButton!
    @IBOutlet var signupviewbtn: UIButton!
    
    
    @IBOutlet var signupButton: UIButton!
    
    @IBOutlet var fbloginButton: UIButton!
    
    var currentUser: String = ""
    var name: String = ""
    var email: String = ""
    var providerPassword: String = ""
    var usernameEmail: String = ""
    var usernameFb: String = ""
    
    var facebookID: String = ""
    var accountType: String = ""

    var emailAcctId: String = ""
    var fbAcctId: String = ""
    var auth: String = ""
    
 // var auth: Auth? = Auth.auth()
 // var currentUser = Auth.auth().currentUser

    override func viewDidLoad() {
        super.viewDidLoad()
    
   //   let fbloginButton = FBSDKLoginButton()
        fbloginButton.layer.cornerRadius = 10
   //   fbloginButton.readPermissions = ["email", "public_profile"]
        
        self.navigationController?.isNavigationBarHidden = true

        
//        let user = Auth.auth().currentUser
//        let emcredential = EmailAuthProvider.credential(withEmail: self.email, password: self.providerPassword)
//        user?.linkAndRetrieveData(with: emcredential) { (authResult, error) in
//            if let error = error {
//                print ("error")
//
//            }
//               print(emcredential)
//               print(self.email)
//               print(self.providerPassword)
//            }
//
//        if let providerData = Auth.auth().currentUser?.providerData {
//               for userInfo in providerData {
//
//                let prevUserProviderUID = userInfo.uid
//                print ("prevUserProviderUID")
//             }
//        }
        

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
     
//        if let user = Auth.auth().currentUser {
//        self.performSegue(withIdentifier: "showLogin", sender: self)
//        }
        
    }
    
    
    @IBAction func loginviewDidTapped (_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginEmailViewController")
        self.navigationController?.pushViewController(vc!, animated: true)
        
        
    }
    
    @IBAction func onSignUpTapped(_ sender: Any) {
        
//        guard let username = usernameTextField.text else { return }
//        guard let email = emailTextField.text else { return }
//        guard let password = passwordTextField.text else { return }
    
        
        if usernameTextField.text == "" || emailTextField.text == "" || passwordTextField.text == "" {
            
            let alertController = UIAlertController(title: "Oops", message: "We can't proceed because one of the fields is blank. Please note that all fields are required.", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
            
            return
            
        }
        
            let usernameEmail = usernameTextField.text
            let email = emailTextField.text
            let providerPassword = passwordTextField.text
    
    
        //if email is 1st login, create a new user below via email...
        
        let credential = EmailAuthProvider.credential(withEmail: email!, password: providerPassword!)
        
        Auth.auth().createUser(withEmail: email!, password: providerPassword!) { user, error in
                    if error == nil && user != nil {
                
        // this is simply to pass over the Username created, by no means does it create any users.. carry on...
                if let user = user {
                    
                    let changeRequest = user.createProfileChangeRequest()
                    changeRequest.displayName = usernameEmail
                    changeRequest.commitChanges(completion: { (error) in
                        guard error == nil else {
                            print(error?.localizedDescription as Any)
                            
                    let uid = user.uid
                    let email = user.email
                
                    return
                            
                    }})
                
                    let uid = user.uid
                    let user = Auth.auth().currentUser!
                    let ref = Database.database().reference()
                    let key = Database.database().reference().childByAutoId().key
                    
                
             let newUser: [String: Any]  = ["username"          :   self.usernameTextField.text!,
                                            "email"             :   self.emailTextField.text!,
                                            "providerPassword"  :   self.passwordTextField.text!,
                                            "providerUID"       :   "\(user.uid)",
                                            "providerID"        :   "password",
//                                          "createdOn"         :   Date()
                
                                                                                                    ]
            
                
                    ref.child("users").child(user.uid).childByAutoId().setValue(newUser)
            
                    
               let vc = self.storyboard?.instantiateViewController(withIdentifier: "NotesTableViewController")
               self.navigationController?.pushViewController(vc!, animated: true)
                
               }}}
        
//        //if FB provider exist login
//
//        let fbcredential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
//        Auth.auth().signInAndRetrieveData(with: fbcredential) { (authResult, error) in
//            if let error = error {
//
//                return
//
//            } else {
//
//                let credential = EmailAuthProvider.credential(withEmail: email!, password: providerPassword!)
//
//                let user = Auth.auth().currentUser
//
//                user?.linkAndRetrieveData(with: credential) { (authResult, error) in
//
//                    if let error = error {
//
//                        return
//                    }
//
//                    print(fbcredential)
//
//                }
//            }}
        
    
        sendEmailVerification()
        //   setupUserInfo()
        
        return
        
        
  }
    
    func setupUserInfo() {
        
   //   appending userinfo into firebase
//        let user = Auth.auth().currentUser
//        let ref = Database.database().reference()
//        let usersReference = ref.child("users")
//
//
//        let newUser = ["usename"       :   self.usernameTextField.text!,
//                       "email"         :   self.emailTextField.text!,
//                       "password"      :   self.passwordTextField.text!,
//                       "userID"        :   "\(user.uid)"
//                                                                            ]
//        usersReference.setValue(newUser)
        
    
    }
    
    func sendEmailVerification() {
        

            Auth.auth().currentUser?.sendEmailVerification(completion: { (error) in
                if error != nil {
                    let emailnotsentAlert = UIAlertController(title: "Email verification", message: "Verification email failed to send: \(String(describing: error?.localizedDescription))", preferredStyle: .alert)
                    emailnotsentAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(emailnotsentAlert, animated: true, completion: nil)
                
                } else {
                    
                    let emailSentAlert = UIAlertController(title: "Email verification", message: "Verification email has been sent. Please tap on the link in the email to verify your account, to proceed with login.", preferredStyle: .alert)
                    emailSentAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(emailSentAlert, animated: true, completion : {
                        self.dismiss(animated: true, completion: nil)
                    })
                
    }
                do {
                    try Auth.auth().signOut()
                } catch {
                    // ERROR HANDLING
                }
            })
    }

    
    ///using fbloginbutton ////
    
    @IBAction func loginFb(_ sender: Any) {
        
        
        //this is to read fb profile for login permission
        
        FBSDKLoginManager().logIn(withReadPermissions: ["email", "public_profile"], from: self) {
            (result, err)  in
            
            if err != nil {
                print("Custom FB Login failed:", err ?? "")
                return
            }
        
    
//            if let userToken = result?.token {
//
//                let token: FBSDKAccessToken = result!.token
//
//                print("Token = \(FBSDKAccessToken.current().tokenString)")
//                print("User ID = \(FBSDKAccessToken.current().userID)")
//
//                let userfbID = FBSDKAccessToken.current().userID
//
//            }

             /// IF THERE IS NO EMAIL CREDENTIAL, SIGN WITH FB CREDENTIAL TO CREATE A NEW USER...
        
                 let accessToken = FBSDKAccessToken.current()
                 let facebookID = FBSDKAccessToken.current().userID
                 guard let accessTokenString = accessToken?.tokenString else { return }
        
                 let fbcredential = FacebookAuthProvider.credential(withAccessToken: accessTokenString)
        
      //      let fbcredential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString!)
            Auth.auth().signIn(with: fbcredential, completion: { (user, error) in

                if let error = error {
                    return
                }
                
                if user != nil {
                        let uid = user?.uid
                        let email = user?.email
                        let name = user?.displayName
        
                                print(uid)
                                print(email)
                
                        let ref = Database.database().reference()
                
                        let newUser: [String: Any] = [ "email"           :   email,
                                                       "username"        :   name,
                                                       "facebookID"      :   facebookID,
                                                       "providerUID"     :   "\(user!.uid)",
                                                       "providerID"      :   "facebook.com",
                //                                     "createdOn"       :   Date(),
                            
                                                                                                ]
                
                ref.child("users").child(user!.uid).childByAutoId().setValue(newUser)
              
                print("facebook login is linked with\(user)")
                
                }
                
                })

        
        //IF EMAIL EXIST, SIGN IN FB CREDENTIAL THROUGH  SIGN IN AND RETRIEVE DATA VIA EMAIL:
        
//            let credential = EmailAuthProvider.credential(withEmail: self.email, password: self.providerPassword)
//
//            Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
//                if let error = error {
//
//                    return
//
//                    } else {
//
//                        let accessToken = FBSDKAccessToken.current()
//                        let userfbID = FBSDKAccessToken.current().userID
//                        guard let accessTokenString = accessToken?.tokenString else { return }
//
//                        let credential = FacebookAuthProvider.credential(withAccessToken: accessTokenString)
//
//                        let user = Auth.auth().currentUser
//
//                        user?.linkAndRetrieveData(with: credential) { (authResult, error) in
//
//                            if let error = error {
//
//                                return
//                            }
//
//                            print(credential)
//
//                            }
//            }}
            
        
        
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "NotesTableViewController")
            self.navigationController?.pushViewController(vc!, animated: true)
            
        }
        
    }
            
            
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        if error != nil {
            
            print(error)
            return
        }
    
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print ("did logout")
    }
        
        
    func createFbAccount() {
        
//            if let providerData = Auth.auth().currentUser?.providerData {
//                for userInfo in providerData {
//
//                    let prevUserProviderUID = userInfo.uid
//                    print ("prevUserProviderUID")
//                }}
//            }
        
//        let prevUser = Auth.auth().currentUser
//
//         if  prevUser != nil  {
//
//
//    ///  if there is no email user, append facebook profile under fb uid
//
//         let accessToken = FBSDKAccessToken.current()
//         let userfbID = FBSDKAccessToken.current().userID
//         guard let accessTokenString = accessToken?.tokenString else { return }
//
//         let credential = FacebookAuthProvider.credential(withAccessToken: accessTokenString)
//         Auth.auth().signIn(with: credential, completion: { (user, error) in
//
//   //                if user != nil {
//                            let uid = user?.uid
//                            let email = user?.email
//                            let name = user?.displayName
//                            let fbID = FBSDKAccessToken.current().userID
//
//                            print(uid)
//                            print(email)
//
//                            let ref = Database.database().reference()
//
//               let newUser: [String: Any] = [ "email"           :   email,
//                                              "username"        :   name,
//                                              "facebookID"      :   fbID,
//                                              "providerUID"     :   "\(user!.uid)",
//                                              "providerID"      :   "facebook.com",
////                                            "createdOn"       :   Date(),
//                                                                                    ]
//
//
//                ref.child("users").child(user!.uid).childByAutoId().setValue(newUser)
//
//                print("successfully created new firebase user and logged in with user: ", user ?? "")
//
//                let vc = self.storyboard?.instantiateViewController(withIdentifier: "NotesTableViewController")
//                self.navigationController?.pushViewController(vc!, animated: true)
//
//                return
//
//                })
//
//                } else {
        
        // A user account (email) has already been created
            
//            let accessToken = FBSDKAccessToken.current()
//            let userfbID = FBSDKAccessToken.current().userID
//            guard let accessTokenString = accessToken?.tokenString else { return }
//
//            let credential = FacebookAuthProvider.credential(withAccessToken: accessTokenString)
//            Auth.auth().signIn(with: credential, completion: { (user, error) in
//
//            let prevUser = Auth.auth().currentUser
//            if  prevUser == prevUser {
//
//            if let providerData = Auth.auth().currentUser?.providerData {
//                 for userInfo in providerData {
//
//                 let prevProviderUID = userInfo.uid
//
//
//                 let uid = prevUser!.uid
//                 let email = prevUser!.email
//                 let name = prevUser!.displayName
//                 let fbID = FBSDKAccessToken.current().userID
//
//                 print(uid)
//                 print(email)
//
//                 let user = Auth.auth().currentUser
//                 let ref = Database.database().reference().child("users").child(prevProviderUID)
//
//                 let newUser: [String: Any] = [ "email"           :   email,
//                                                "username"        :   name,
//                                                "facebookID"      :   fbID,
//                                                "providerUID"     :   "\(user!.uid)",
//                                                "providerID"      :   "facebook.com",
//                    //                          "createdOn"       :   Date(),
//                                                                                                ]
//
//                ref.childByAutoId().setValue(newUser)
//
//                print("successfully created new provider and logged in with fb user: ", prevUser ?? "")
//
//                let vc = self.storyboard?.instantiateViewController(withIdentifier: "NotesTableViewController")
//                self.navigationController?.pushViewController(vc!, animated: true)
//
//                }}
//                }
//
//            })
        
      //          print ("error")

    }
    
    func fbinfoRequest() {
        
        //to show information on facebook
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email"]).start {
            (connection, user, err) in
            
           if err != nil {
        
                print("Failed to start graph request:", err ?? "")
                return
            }
            
            print(user)

            }
    }
    
    func finishLoggingIn() {
        
//        let rootViewController = UIApplication.shared.keyWindow?.rootViewController
//        guard let mainNavigationController = rootViewController  as?  MainNavigationController else { return }
//
//        mainNavigationController.viewControllers = [NotesTableViewController()]
//
//        UserDefaults.standard.set(true, forKey: "isLoggedIn")
//        dismiss(animated: true, completion: nil)
//    }
    }
    
  }





