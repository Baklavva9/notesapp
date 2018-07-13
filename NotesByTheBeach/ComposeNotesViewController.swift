//
//  ComposeNotesViewController.swift
//  NotesByTheBeach
//
//  Created by Izati Ng on 2/5/18.
//  Copyright © 2018 bklv. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FBSDKLoginKit

class ComposeNotesViewController: UIViewController {
    
    @IBOutlet var doneComposeBarButtonItem: UIBarButtonItem!
    @IBOutlet var cancelBarButtonItem: UIBarButtonItem!
    
    
    @IBOutlet var categoryTextField: UITextField!
    @IBOutlet var expenseTextField: UITextField!
    
    @IBOutlet var composeTextView: UITextView!
    @IBOutlet var addnoteButton: UIButton!
    
    var textNotes: String = ""
    var category: String = ""
    var expense: String = ""
    var noteId: String = ""
    
    //for cloudfirestore
 //   let db = Firestore.firestore()
    
    let ref = Database.database().reference()
    
    // for loggedin user
    let user = Auth.auth().currentUser
    
    
    
    func textViewShouldReturn(_ composeTextView: UITextView) -> Bool {
        composeTextView.resignFirstResponder()
        return true
    }
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        if let nextTextField = view.viewWithTag(textField.tag + 1) {
//            textField.resignFirstResponder()
//         //   nextTextField.becomeFirstResponder()
//        }
//
//        return true
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = doneComposeBarButtonItem
        self.navigationItem.leftBarButtonItem = cancelBarButtonItem
        
        
        // defining text input variable
        composeTextView.text = ""
        categoryTextField.text = ""
        expenseTextField.text = ""
        
//         let loggedinuser = Auth.auth().currentUser?.uid
//         print (loggedinuser)
        
//        let user = Auth.auth().currentUser!
//        let uid = user.uid
//        print(uid)
        
        
        
//        let accessToken = FBSDKAccessToken.current()
//        let userfbID = FBSDKAccessToken.current().userID
//        guard let accessTokenString = accessToken?.tokenString else { return }
//
//        let credential = FacebookAuthProvider.credential(withAccessToken: accessTokenString)
//
//        user?.linkAndRetrieveData(with: credential) { (authResult, error) in
//
//            if let error = error {
//
//                let user = self.user
//
//                return
//            }
//            print(credential)
//        }

        
    }
    

    @IBAction func doneCompose(_ sender: Any) {
        
        if composeTextView.text != "" || categoryTextField.text != "" || expenseTextField.text != "" {
            
            if Auth.auth().currentUser != nil {
                
                let user = Auth.auth().currentUser
            
                let loggedinuser = Auth.auth().currentUser?.uid
                
                let ref = Database.database().reference()
    
                let key = ref.childByAutoId().key
        
                let newNote = [ "noteId"      : key,
                                "textNotes"   : self.composeTextView.text!,
                                "category"    : self.categoryTextField.text!,
                                "expense"     : self.expenseTextField.text!,
                                                                                ]
    
     //      ref.child("notes").child(user).childByAutoId().setValue(newNote) {
     //      ref.child("notes").child(loggedinuser!).child(key).setValue(newNote) {
             ref.child("notes").child(loggedinuser!).child(key).setValue(newNote) {

            (error:Error?, ref:DatabaseReference) in
            if let error = error {
                print("Data could not be saved: \(error).")
            } else {
                print("Data saved successfully!")
            }
            }
    }
        
        dismiss(animated: true, completion: nil)
    
    }
    
   }
}





