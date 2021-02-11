//
//  CreateFolderVC.swift
//  Doc Scanner
//
//  Created by Fahim Rahman on 12/1/21.
//

import UIKit

// MARK: - Create Folder View Controller

class CreateFolderVC: UIViewController, UITextFieldDelegate {
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var folderNameInputTextField: UITextField!
    
    
    // MARK: - View Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setCustomNavigationBar(largeTitleColor: UIColor.black, backgoundColor: UIColor.white, tintColor: UIColor.black, title: "New Folder", preferredLargeTitle: false)
        
        self.setViewCustomColor(view: self.view, color: .white)
        
        self.setFolderNameInputTextField()
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - View Will Appear
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.setAddKeyboardObserver()
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - View Will Disappear
    
    override func viewWillDisappear(_ animated: Bool) {
        
        self.setRemoveKeyboardObserver()
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Text Field Should Return
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        print(#function)
        
        if self.folderNameInputTextField.text != "" {
            
            self.writeFolderToRealm(folderName: self.folderNameInputTextField.text!)
    
            self.folderNameInputTextField.resignFirstResponder()
        }
        self.folderNameInputTextField.resignFirstResponder()
        return true
    }
}
