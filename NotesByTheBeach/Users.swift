//
//  Users.swift
//  NotesByTheBeach
//
//  Created by Xcode Server on 13/6/18.
//  Copyright © 2018 bklv. All rights reserved.
//

import Foundation
import Firebase

class User {
    
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
    var providerID: String = ""
    
    var userID: String? = nil
    
    var lastLogin: Date!
    var uid: Int!
    var createdOn: Date!
    
    var emailprovider = [EmailAuthProvider]()
    var facebookprovider = [FacebookAuthProvider]()

    let ref: DatabaseReference!
    
//        init(text: String) {
//
//            self.username = text
//            self.password = text
//            self.userID = Int
//            self.email = text
    
    init(currentUser: String, usernameEmail: String, usernameFb: String, providerPassword: String, email: String, userID: String, facebookID: String, accountType: String, createdOn: Date, lastLogin: Date, emailAcctId: String, fbAcctId: String, auth: String, providerID: String) {
        
                self.currentUser = currentUser
                self.email = email
                self.usernameEmail = usernameEmail
                self.usernameFb = usernameFb
                self.providerPassword = providerPassword
                self.userID = userID
        
                self.facebookID = facebookID
                self.accountType = accountType
                self.createdOn = createdOn
                self.lastLogin = lastLogin
        
                self.emailAcctId = emailAcctId
                self.fbAcctId = fbAcctId
                self.auth = auth
                self.providerID = providerID
        
        
            let user = Auth.auth().currentUser
            ref = Database.database().reference().child("users")
    
        }
    
    init(snapshot: DataSnapshot) {
        
        ref = snapshot.ref
        
        if let value = snapshot.value as? [String: Any] {
            
            
            currentUser = value["currentUser"] as! String
            email = value["email"] as! String
            providerPassword = value["providerPassword"] as! String
            usernameEmail = value["usernameEmail"] as! String
            usernameFb = value["usernameFb"] as! String
            userID = value["userID"] as? String
            facebookID = value["facebookID"] as! String
            providerID = value["providerID"] as! String

            emailAcctId = value["emailAcctId"] as! String
            fbAcctId = value["userID"] as! String
            
            
        }
    }
}
