//
//  EditBigNotesViewController.swift
//  NotesByTheBeach
//
//  Created by Xcode Server on 13/6/18.
//  Copyright © 2018 bklv. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class EditBigNotesViewController: UIViewController {
    
    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var notesLabel: UILabel!
    @IBOutlet var noteIdLabel: UILabel!
    
    @IBOutlet var expenseTextField: UITextField!
    
    @IBOutlet var confirmButton: UIButton!
    
    var note: Note!
    
//  var ref: DatabaseReference?
    let ref = Database.database().reference().child("notes")
    
    var category: String = ""
    var expense: String = ""
    var textNotes: String = ""
    var noteId: String = ""
    var notenodeId: String = ""
    
//    var category: String!
//    var expense: String!
//    var textNotes: String!
//    var byUser: String!
    
    let user = Auth.auth().currentUser
    
    var keyArray: [String] = []
    
    var users = [User]()
    
    var loggedInUser: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

         self.categoryLabel.text = category
         self.expenseTextField.text = "\(expense)"
         self.notesLabel.text = textNotes
         self.noteIdLabel.text = noteId
        
      //   self.loggedInUser = Auth.auth().currentUser!
        

        
  //      getAllKeys()

    }
    
    @IBAction func confirmEdit(_ sender: Any) {
        
        
        if expenseTextField.text != "" {
            
            let user = Auth.auth().currentUser!
            let uid = Auth.auth().currentUser!.uid
            let loggedinuser = Auth.auth().currentUser?.uid
    
            let ref = Database.database().reference().child("notes").child(loggedinuser!).child(noteId)
          
            let note : [String: Any] = [ "category"    :  self.category,
                                         "expense"     :  self.expenseTextField.text!,
                                         "textNotes"   :  self.textNotes,
                                         "noteId"      :  self.noteId
                                                                                ]
        
            ref.setValue(note) {
        
       //       self.ref.child("notes/\(user.uid)/note").setValue(note) {
  
                (error:Error?, ref:DatabaseReference) in
                if let error = error {
                    print("Data could not be saved: \(error).")
                } else {
                    print("Data saved successfully!")
                }
            }

            }
    }

    func getAllKeys() {
        
//        let user = Auth.auth().currentUser!
//        let ref = Database.database().reference().child("notes").child(user.uid).childByAutoId()
//
//            ref.observe(DataEventType.value, with: { (snapshot) in
//
//                    if let dictionary = snapshot.value as? [String: AnyObject] {
//                        let expense = dictionary["expense"] as? String
//                        print(expense)
//
//                    }
//                })
//  }
    }
}




//            ref.observe(DataEventType.value, with: { (snapshot) in
//
//                if let dictionary = snapshot.value as? [String: AnyObject] {
//
//                    let newExpense = dictionary["expense"] as! String
//                    let editExpense = ["expense" : self.expenseTextField.text]
//
//          //        ref.setValue(editExpense)
//                    ref.child("notes/\(user!.uid)/expense").setValue(editExpense)
//
//                    }
//                })

