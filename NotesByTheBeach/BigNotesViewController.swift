//
//  BigNotesViewController.swift
//  NotesByTheBeach
//
//  Created by Xcode Server on 13/6/18.
//  Copyright © 2018 bklv. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class BigNotesViewController: UIViewController {
    
    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var expenseLabel: UILabel!
    @IBOutlet var notesLabel: UILabel!
    @IBOutlet var noteIdLabel: UILabel!
    
    @IBOutlet var editButton: UIButton!
    
    var note: Note!
    
    let ref = Database.database().reference()

    var category: String = ""
    var expense: String = ""
    var textNotes: String = ""
    var noteId: String = ""


    
    override func viewDidLoad() {
        super.viewDidLoad()

        categoryLabel.text = category
        expenseLabel.text = expense
        notesLabel.text = textNotes
        noteIdLabel.text = noteId
    }

    @IBAction func editDidTapped(_ sender: Any) {
        
        if let vcEdit = storyboard?.instantiateViewController(withIdentifier: "EditBigNotesViewController") as?
        EditBigNotesViewController {
        
        vcEdit.category = category
        vcEdit.expense = expense
        vcEdit.textNotes = textNotes
        vcEdit.noteId = noteId
        
        self.navigationController?.pushViewController(vcEdit, animated: true)
        }
    }
    
}
