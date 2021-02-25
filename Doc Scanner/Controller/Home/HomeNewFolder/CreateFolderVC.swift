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
    
    @IBOutlet weak var CustomView: UIView!
    
    
    
    // MARK: - View Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.setCustomNavigationBar(largeTitleColor: UIColor.black, backgoundColor: UIColor.white, tintColor: UIColor.black, title: "New Folder", preferredLargeTitle: false)
        
        //self.setViewCustomColor(view: self.view, color: .white)
        
        self.setFolderNameInputTextField()
        CustomView.layer.cornerRadius = 10.0
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - View Will Appear
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.setAddKeyboardObserver()
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - View Will Disappear
    
//    override func viewWillDisappear(_ animated: Bool) {
//
//        self.setRemoveKeyboardObserver()
//    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        print("hello")
        super.viewWillDisappear(animated)
        self.setRemoveKeyboardObserver()
        if let firstVC = presentingViewController as? HomeVC{
            print("inside will dissapier!!!!")
            DispatchQueue.main.async {
                firstVC.docsAndFoldsTableView.reloadData()
                firstVC.docsAndFoldsCollectionView.reloadData()
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("in dissapiear")
         let firstVC = presentingViewController as? HomeVC
            print("indididid")
            DispatchQueue.main.async {
                firstVC?.docsAndFoldsTableView.reloadData()
                firstVC?.docsAndFoldsCollectionView.reloadData()
            }
        
    }
  
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Text Field Should Return
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//
//        print(#function)
//
//        if self.folderNameInputTextField.text != "" {
//
//            self.writeFolderToRealm(folderName: self.folderNameInputTextField.text!)
//
//            self.folderNameInputTextField.resignFirstResponder()
//        }
//        self.folderNameInputTextField.resignFirstResponder()
//        return true
//    }
    
    
    @IBAction func CancelClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func DoneClicked(_ sender: UIButton) {
        
        if self.folderNameInputTextField.text != "" {
            
            self.writeFolderToRealm(folderName: self.folderNameInputTextField.text!)
    
            self.folderNameInputTextField.resignFirstResponder()
        }
        self.folderNameInputTextField.resignFirstResponder()
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
