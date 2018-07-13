//
//  DesignableTextField.swift
//  NotesByTheBeach
//
//  Created by Xcode Server on 5/6/18.
//  Copyright © 2018 bklv. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

@IBDesignable class DesignableTextField: UITextField {
    
    @IBInspectable var leftImage: UIImage? {
        didSet {
        
            updateView()
        }
    }
    
    @IBInspectable var leftPadding: CGFloat = 10 {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }

    func updateView() {
        
        if let image = leftImage {
            leftViewMode = .always
            
            let imageView = UIImageView(frame: CGRect(x: (leftPadding + 20), y: 0, width: 20, height: 20))
            imageView.image = image
            
            let width = leftPadding + 20
            
            let view = UIView(frame: CGRect(x: 0, y: 0, width: (leftPadding + 20), height: 20))
            view.addSubview(imageView)
            
            leftView = imageView
        
        } else {
            return
        }
    }

}
