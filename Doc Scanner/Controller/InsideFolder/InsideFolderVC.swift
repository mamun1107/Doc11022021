//
//  InsideFolderVC.swift
//  Doc Scanner
//
//  Created by LollipopMacbook on 20/2/21.
//

import UIKit
import VisionKit
import RealmSwift

class InsideFolderVC: UIViewController {
    
    @IBOutlet weak var topBarStackView: UIStackView!
    
    
    var primaryKeyName:String?
    var titleHeader:String?
    
    
    var gridButttonSelected = Bool()
    var listButtonSelected = Bool()
    
    var docsTableView: UITableView = UITableView()
    var docsCollectionView: UICollectionView!
    
    var insideDocuments = [Documents]()
    
    var homeObject:HomeVC?
    var listSelect:Bool = Bool()
    var gridSelect:Bool = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initVC()
        self.insideDocuments.removeAll()
        
        guard let primaryKey = self.primaryKeyName else {return}
        self.insideDocuments = self.readDocumentFromRealm(folderName: primaryKey, sortBy: "documentSize")
        
        
        if self.listButtonSelected == true{
            self.listSelect = true
            self.gridSelect = false
            self.setinsideDocumentTableView()
            self.docsTableView.tableFooterView = UIView()
            self.docsTableView.reloadData()
            
        }
        else if self.gridButttonSelected == true{
            print("inside here!!")
            self.listSelect = false
            self.gridSelect = true
            self.setDocumentCollectionView()
            self.docsCollectionView.reloadData()
            
            
        }
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("will appear")
        if self.gridButttonSelected == true{
            print("inside here!!")
            self.listSelect = false
            self.gridSelect = true
            self.setDocumentCollectionView()
            self.docsCollectionView.reloadData()
            
            
        }
    }
    
    
    //MARK:- scanner button clicked
    @IBAction func ScanButtonClicked(_ sender: UIButton) {
        print("scanner button clicked")
    }
    
    
    @IBAction func listButtonClicked(_ sender: UIButton) {
        print("list clicked")
        
        if self.listSelect == false{
            self.listSelect = true
            self.gridSelect = false
            self.docsCollectionView.removeFromSuperview()
            self.setinsideDocumentTableView()
            self.docsTableView.tableFooterView = UIView()
            self.docsTableView.reloadData()
        }
        
        
        
    }
    
    
    @IBAction func gridListButtonClicked(_ sender: UIButton) {
        print("grid clicked")
        if self.gridSelect == false{
            self.gridSelect = true
            self.listSelect = false
            self.docsTableView.removeFromSuperview()
            self.setDocumentCollectionView()
            self.docsCollectionView.reloadData()
        }
        
    }
    
    
    
    @IBAction func filterButtonClicked(_ sender: UIButton) {
    }
    
    
    
    
}


// MARK:-












extension InsideFolderVC{
    
    func initVC(){
        // self.gridButttonSelected = false
        //self.listButtonSelected = true
        self.setCustomNavigationBar(largeTitleColor: UIColor.black, backgoundColor: UIColor.white, tintColor: UIColor.black, title: "\(self.titleHeader ?? "")", preferredLargeTitle: true)
        
        self.setViewCustomColor(view: self.view, color: UIColor(hex: "EEEEEE"))
        self.setNavigationElements()
    }
    
    
    func setNavigationElements() {
        
        // MARK:- Selection  Bar select and delete Button
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Select", style: .plain, target: self, action: #selector(selection))
        
    }
    
    @objc func selection() {
        print(#function)
        
        self.navigationItem.rightBarButtonItem?.title = "Select"
        
    }
    
    
    
}



class AleartsInsideFolder {
    
    func showOptionActionSheet(controller: InsideFolderVC, folderName: String, from:String, passwordProtected:Bool, index_option:Int, section:String) {
        
       
        
        let alert = UIAlertController(title: "", message: "Please Select an Option", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Set Password", style: .default, handler: { (_) in
            
            AleartsInsideFolder().showSetPassAlert(controller: controller, folderName: folderName, from: from, section:section)
        }))
        
        alert.addAction(UIAlertAction(title: "Rename", style: .default, handler: { (_) in
            
            if (passwordProtected == true){
                AleartsInsideFolder().showGetPassAlert(controller: controller, currentPassword: controller.insideDocuments[index_option].password!, index: index_option, from: "doc", for_using:"rename", passwordProtected:passwordProtected, section: section)
                
            }else if (passwordProtected == false){
                AleartsInsideFolder().setInsideDocumentRename(controller: controller, folderName: folderName, passwordProtection:passwordProtected, from:from, section:section)
                
            }
            // Alerts().setRename(controller: controller, folderName: folderName, passwordProtection:passwordProtected, from:from)
        }))
        
        
        
        //MARK:- Share.....
        
        if ( from == "doc"){
            
            alert.addAction(UIAlertAction(title: "Share", style: .default, handler: { (_) in
                
                if (passwordProtected == true && from == "doc" ){
                    
                    AleartsInsideFolder().showGetPassAlert(controller: controller, currentPassword: controller.insideDocuments[index_option].password!, index: index_option, from: "doc", for_using:"share", passwordProtected:passwordProtected, section: section)
                    
                    
                    
                }else if (passwordProtected == false){
                    
                    let shareVC = UIActivityViewController(activityItems: [ UIImage(data: controller.insideDocuments[index_option].documentData ?? Data()) as Any], applicationActivities: nil)
                    
                    controller.present(shareVC, animated: true)
                    
                    
                }
                
            }))
        }
        
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (_) in
            
            if passwordProtected == true{
                //                (from == "folder") ? Alerts().showGetPassAlert(controller: controller, currentPassword: controller.myFolders[index_option].password!, index: index_option, from: "folder", for_using:"delete", passwordProtected:passwordProtected) : Alerts().showGetPassAlert(controller: controller, currentPassword: controller.myDocuments[index_option].password!, index: index_option, from: "doc", for_using:"delete", passwordProtected:passwordProtected)
                
            }else {
                print("hi....")
                UIViewController().deleteInsideFolderDocumentFromRealm(documentName: folderName, controller: controller, section: section)
                
                
            }
            
            
        }))
        
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { (_) in
            print("User click Dismiss button")
        }))
        
        controller.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    
    func showSetPassAlert(controller: InsideFolderVC, folderName: String, from: String, section:String) {

        let alertController = UIAlertController(title: "Set a password", message: nil, preferredStyle: .alert)

        let confirmAction = UIAlertAction(title: "Set", style: .default) { (_) in
            if let txtField = alertController.textFields?.first, let text = txtField.text {
                
                UIViewController().setInsideDocumentPasswordToRealm(documentName: folderName, password: text, controller:controller, section: section)
                
                
            }
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        alertController.addTextField { (textField) in
            textField.placeholder = "Password"
        }

        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        controller.present(alertController, animated: true, completion: nil)
    }
//
//
//-------------------------------------------------------------------------------------------------------------------------------------------------
//
//
//    //work for password
    func showGetPassAlert(controller:InsideFolderVC, currentPassword: String, index: Int, from: String, for_using: String, passwordProtected:Bool, section:String) {


        let alertController = UIAlertController(title: "Enter your password", message: nil, preferredStyle: .alert)

        let confirmAction = UIAlertAction(title: "OK", style: .default) { (_) in
            if let txtField = alertController.textFields?.first, let text = txtField.text {

 

                // for document and setpassword option
                if (from == "doc" && for_using == "password"){

                    if text == currentPassword{
                        
                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let editVC = storyBoard.instantiateViewController(withIdentifier: "editVC") as! EditVC
                        editVC.editImage = UIImage(data: controller.insideDocuments[index].documentData ?? Data()) ?? UIImage()
                        editVC.currentDocumentName = controller.insideDocuments[index].documentName ?? String()

                        controller.navigationController?.pushViewController(editVC, animated: false)
                    }
                    else{
                        controller.showMessageToUser(title: "Message", msg: "your password is worng try again")
                    }

                }
              //  document and rename option calling...
                else if (from == "doc" && for_using == "rename") {
                    if text == currentPassword{
                        AleartsInsideFolder().setInsideDocumentRename(controller: controller, folderName: controller.insideDocuments[index].documentName!, passwordProtection: controller.insideDocuments[index].isPasswordProtected, from: "doc", section: section)
                    }else{
                        controller.showMessageToUser(title: "Message", msg: "your password is worng try again")
                    }

                }

                // delete for folder

                else if (from == "doc"  && for_using == "delete"){
                    (text == currentPassword) ? UIViewController().deleteInsideFolderDocumentFromRealm(documentName: controller.insideDocuments[index].documentName!, controller: controller, section: section) : controller.showMessageToUser(title: "Message", msg: "your password is worng try again")
                }

                else if (from == "doc" && for_using == "share"){

                    let shareVC = UIActivityViewController(activityItems: [ UIImage(data: controller.insideDocuments[index].documentData ?? Data()) as Any], applicationActivities: nil)

                    controller.present(shareVC, animated: true)
                }

            }
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        alertController.addTextField { (textField) in
            textField.placeholder = "Password"
        }

        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        controller.present(alertController, animated: true,completion: nil)


    }

    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
//
//
    func setInsideDocumentRename(controller: InsideFolderVC, folderName: String, passwordProtection:Bool, from:String, section:String) {

        let alertController = UIAlertController(title: "Set a name", message: nil, preferredStyle: .alert)

        let confirmAction = UIAlertAction(title: "Set", style: .default) { (_) in
            if let txtField = alertController.textFields?.first, let text = txtField.text {
                
                UIViewController().setRenameInsideDocumentToRealm(documentName: folderName, newName: text, setpassword:passwordProtection, controller: controller, section: section)
                
                
                
            }
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        alertController.addTextField { (textField) in
            textField.placeholder = "Name"
        }

        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        controller.present(alertController, animated: true, completion: nil)
    }
}
