//
//  NotesTableViewController.swift
//  NotesByTheBeach
//
//  Created by Izati Ng on 1/5/18.
//  Copyright © 2018 bklv. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FBSDKLoginKit
import FirebaseAuthUI
import FirebaseFacebookAuthUI
import FirebaseGoogleAuthUI
import GoogleSignIn

class NotesTableViewController: UITableViewController, FUIAuthDelegate {

    
    @IBOutlet var rightBarButtonItem: UIButton!
    @IBOutlet var leftBarButtonItem: UIButton!
    
    var notes = [Note]()
    var note: Note!
    
    var users = [User]()
    
    var currentUser: String = ""
    var textNotes: String = ""
    var category: String = ""
    var expense: String = ""
    var byUser: String = ""
    var noteId: String = ""
    
    var providerPassword: String = ""
    var emailAcctId: String = ""
    var fbAcctId: String = ""
    var auth: String = ""

    var email: String = ""
    var password: String = ""
    
//  var facebookProvider = FUIFacebookAuth()
//  var googleProvider = FUIGoogleAuth()
    
    
 // let db = Firestore.firestore()
 // let ref = Database.database().reference()
    
    var ref: DatabaseReference?
    
 //   var emailprovider = [EmailAuthProvider]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // use 1st login firebase UID (providerData) to append data
    //      let auth: Auth? = Auth.auth()

         self.navigationController?.isNavigationBarHidden = false
         self.navigationController?.isToolbarHidden = false

    //    updateData()
        
        Auth.auth().addStateDidChangeListener { auth, user in
            if user != nil {
                print ("user is signed in")
            } else {
                print ("user is not signed in")
            }
        }
        
        // Check if fb user is still linked?, link FB
        
   //      self.linkAccount()
   
        // append data to table
        
//        let emailprovider = [EmailAuthProvider]()
//        let credential = EmailAuthProvider.credential(withEmail: email, password: providerPWD)
//        let currentUser = EmailAuthProvider.self
//
//        let user = Auth.auth().currentUser
        
//        user?.linkAndRetrieveData(with: credential) { (authResult, error) in
//            if let error = error {
//                // ...
//                return
//            }
//            print(authResult!)
//        }
        
        let user = Auth.auth().currentUser
        
        if let user = user {
        
        if let providerData = Auth.auth().currentUser?.providerData {
            for userInfo in providerData {
                
                let currentProviderUID = userInfo.uid

                print("user is signed in with \(currentProviderUID)")
            
                
   //       let user = Auth.auth().currentUser
    
        //    let uid = user.uid
            let ref = Database.database().reference()
            let key = ref.childByAutoId().key

            ref.child("notes").child(user.uid).observe(.value) { snapshot in
         
                    self.notes.removeAll()
                    print(snapshot)
        
                    for child in snapshot.children {
                        let noteSnapshot = child as! DataSnapshot
                        let note = Note(snapshot: noteSnapshot)
                
                        self.notes.insert(note, at: 0)
                
                    }
            
                    self.tableView.reloadData()
            
                }}}
        
            
            }
    }
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return notes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath) as! NotesTableViewCell
        
        //Append dictionary to cell
        
        let note = notes[indexPath.row]
        
        cell.categoryLabel.text = note.category
        cell.expenseLabel.text = note.expense
        cell.notesLabel.text = note.textNotes
        cell.noteIdLabel.text = note.noteId
        
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let vcBigNote = storyboard?.instantiateViewController(withIdentifier: "BigNotesViewController") as?
            BigNotesViewController {
        
        let note = notes[indexPath.row]
        
        vcBigNote.category = note.category
        vcBigNote.expense = note.expense
        vcBigNote.textNotes = note.textNotes
        vcBigNote.noteId = note.noteId
            
            
        self.navigationController?.pushViewController(vcBigNote, animated: true)
        }
    }
    
    // Mark: Perform showCompose
    
    func composeNotes(_ sender: Any) {
        performSegue(withIdentifier: "showCompose", sender: rightBarButtonItem)
    }
    
    @IBAction func unwindToHomeScreen(segue:UIStoryboardSegue) {
        
    }
    
}


