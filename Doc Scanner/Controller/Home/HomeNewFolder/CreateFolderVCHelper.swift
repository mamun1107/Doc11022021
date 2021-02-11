//
//  CreateFolderVCHelper.swift
//  Doc Scanner
//
//  Created by Fahim Rahman on 12/1/21.
//

import UIKit

// MARK: - Create Folder VC Helper

extension CreateFolderVC {
    
    
    // MARK: - Set Folder Name Input Text Field
    
    func setFolderNameInputTextField() {
        
        self.folderNameInputTextField.delegate = self
        
        self.folderNameInputTextField.backgroundColor = UIColor(hex: "EEEEEE")
        self.folderNameInputTextField.attributedPlaceholder = NSAttributedString(string: "Type Folder Name", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
        self.folderNameInputTextField.tintColor = .black
        self.folderNameInputTextField.clearButtonMode = .always
        self.folderNameInputTextField.clearsOnBeginEditing = true
        self.folderNameInputTextField.returnKeyType = .done
    }
    
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    
    // MARK: - Set Add Keyboard Observer
    
    func setAddKeyboardObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(CreateFolderVC.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(CreateFolderVC.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Set Remove Keyboard Observer
    
    func setRemoveKeyboardObserver() {
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Keyboard Will Show
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else {return}
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        let keyboardFrame = keyboardSize.cgRectValue
        
        if self.view.bounds.origin.y == 0 {
            self.view.bounds.origin.y += (keyboardFrame.height - 150)
        }
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Keyboard Will Hide
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.bounds.origin.y != 0 {
            self.view.bounds.origin.y = 0
        }
    }
}
