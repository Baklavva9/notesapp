//
//  NotesTableViewCell.swift
//  NotesByTheBeach
//
//  Created by Izati Ng on 1/5/18.
//  Copyright © 2018 bklv. All rights reserved.
//

import UIKit
import Firebase

class NotesTableViewCell: UITableViewCell {
    
    @IBOutlet var notesLabel: UILabel!
    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var expenseLabel: UILabel!
    @IBOutlet var byUserLabel: UILabel!
    @IBOutlet var noteIdLabel: UILabel!
    
    var note: Note! {
        didSet {
            notesLabel.text = note.textNotes
            categoryLabel.text = note.category
            expenseLabel.text = note.expense
            byUserLabel.text = note.byUser
            noteIdLabel.text = note.noteId
            
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
