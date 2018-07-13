//
//  notes.swift
//  NotesByTheBeach
//
//  Created by Izati Ng on 1/5/18.
//  Copyright © 2018 bklv. All rights reserved.
//

import Foundation
import Firebase

class Note {
    
    var textNotes: String = ""
    var category: String = ""
    var expense: String = ""
    var userID: String = ""
    var accountType: String = ""
    var createdOn: Date!
    var lastLogin: Date!
    
    var byUser: String = ""
    var noteId: String = ""
    
    var notenodeId: String = ""
    
    var uid: Int!
        
    var ref: DatabaseReference!
    
 //   var ref: DatabaseReference!
    
    init(noteId: String, text:String, createdOn: Date, lastLogin: Date) {
        
        
        let user = Auth.auth().currentUser
        
        ref = Database.database().reference()
        
        let notenodeId = ref.key
        let key  = ref.childByAutoId().key
        
        self.textNotes = text
        self.category = text
        self.expense = text
        self.userID = text
        
        self.accountType = text
        self.createdOn = createdOn
        self.lastLogin = lastLogin
        self.byUser = text
        self.noteId = key
        self.notenodeId = notenodeId
        
        
        //this is the reference below when using anonymous login
        //ref = Database.database().reference().child("Notes").childByAutoId()
        
//        let user = Auth.auth().currentUser
//        if let user = user {
//            ref = Database.database().reference().child(user.uid).child("notes").childByAutoId()
//        }
        
    }
    
    init(snapshot: DataSnapshot) {

            ref = snapshot.ref

        if let value = snapshot.value as? [String: Any] {
    
            textNotes = value["textNotes"] as! String
            category = value["category"] as! String
            expense = value["expense"] as! String
            noteId = value["noteId"] as! String
            
        
    }
  }
}

//class User {
//
//    var email: String = ""
//    var username: String = ""
//    var password: String = ""
//    var userID: String = ""
//
//}



//func save() {
//
//    ref.setValue(toDictionary())
//
//    }
//
//func toDictionary() -> [String: Any] {
//
//        return [
//            "textNotes" : textNotes,
//            "category" : category,
//            "expense" : expense
//            ]
//
//    }
    


