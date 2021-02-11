//
//  SearchExtentions.swift
//  Doc Scanner
//
//  Created by LollipopMacbook on 9/2/21.
//

import Foundation
import UIKit

extension SearchViewController{
    
    func tableViewinit(){
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    // MARK: - Number Of Rows In Section
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return 1 }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Number Of Section

    
    func numberOfSections(in tableView: UITableView) -> Int {
        if searching {
            return self.filterSearchData.count
        } else {
            return self.allserarchdata.count
        }
        
    }

    //--------------------------------------------------------------------------------------------------------------------------------
 
    
    
    // MARK: - Height For Row At
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    // MARK: - Height For Header In Section
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    // MARK: - View For Header In Section

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "folderCell", for: indexPath) as! docsAndFoldsTVCell

        if searching {
            
            cell.nameLabel.text = self.filterSearchData[indexPath.section].name
            cell.docsAndFoldsImageView.image = self.filterSearchData[indexPath.section].image
            cell.optionButton.isHidden = true
            cell.numberOfItemsLabel.text = self.filterSearchData[indexPath.section].totaldoc
 
   
        
        } else {

            cell.nameLabel.text = self.allserarchdata[indexPath.section].name
            cell.docsAndFoldsImageView.image = self.allserarchdata[indexPath.section].image
            cell.optionButton.isHidden = true
            cell.numberOfItemsLabel.text = self.allserarchdata[indexPath.section].totaldoc


        }
        
        return self.setFolderCell(cell: cell)
    }
    
    func setFolderCell(cell: UITableViewCell) -> UITableViewCell {
        
        let view = UIView()
        view.backgroundColor = UIColor.white
        
        cell.multipleSelectionBackgroundView = view
        cell.backgroundColor = .white
       
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.5
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        
        return cell
    }
    

    // did select Section
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(indexPath.section)
        if searching == true{
            print("inside searching....")
            if self.filterSearchData[indexPath.section].totaldoc != "1 Document"{
                print("folder.. when searching is True")
                didselectFolder(index:indexPath.section, insideSearching:true)
            }else{
                print("file when searching...")
                didselectFile(index: indexPath.section , insideSearching:true)
            }
            
        }else{
           print("no searching....")
            if self.allserarchdata[indexPath.section].totaldoc != "1 Document"{
                print("folder.. when not searching..")
                didselectFolder(index:indexPath.section, insideSearching:false)
            }else{
                print("file when not search...")
                didselectFile(index: indexPath.section, insideSearching:false)
            }
            
        }


   }
    
    
    func didselectFolder(index:Int,insideSearching:Bool){
        
        var didselectfolderName:String = ""
        var passwordWall:Bool
        var passwordforFolder:String
        
        
        didselectfolderName = (self.insideSearching == true) ? self.filterSearchData[index].name ?? "" :  self.allserarchdata[index].name ?? ""
        passwordWall = (self.insideSearching == true) ? self.filterSearchData[index].ispasswordProtected : self.allserarchdata[index].ispasswordProtected
        passwordforFolder = (self.insideSearching == true) ? self.filterSearchData[index].password! : self.allserarchdata[index].password!
        
        
        if let folderGalleryVC = self.storyboard?.instantiateViewController(withIdentifier: "folderGalleryVC") as? FolderGalleryVC {
            
            if passwordWall == false {
                
                folderGalleryVC.folderName = didselectfolderName
                
                self.navigationController?.pushViewController(folderGalleryVC, animated: false)
            }
            else {
                print("here folder is password protected... so Alert")
                
                AlertSearch().getPasswordAlert(controller: self, currentPassword: passwordforFolder, index: index, from: "folder", for_using: "password", passwordProtected: true, insideSearching:insideSearching)
            }
        }
        
        
    }
    func didselectFile(index:Int, insideSearching:Bool){
        
        var didselectdocumentName:String = ""
        var passwordWall:Bool
        var passwordforDocumt:String
        //var image:UIImage
        var originalimage:UIImage
        
        didselectdocumentName = (self.insideSearching == true) ? self.filterSearchData[index].name ?? "" :  self.allserarchdata[index].name ?? ""
        passwordWall = (self.insideSearching == true) ? self.filterSearchData[index].ispasswordProtected : self.allserarchdata[index].ispasswordProtected
        passwordforDocumt = (self.insideSearching == true) ? self.filterSearchData[index].password! : self.allserarchdata[index].password!
        originalimage = (self.insideSearching == true) ? self.filterSearchData[index].originalImage : self.allserarchdata[index].originalImage
        if let editVC = self.storyboard?.instantiateViewController(withIdentifier: "editVC") as? EditVC {
 
            if  passwordWall == true {
                
                editVC.editImage = originalimage
                editVC.currentDocumentName = didselectdocumentName
                
                self.navigationController?.pushViewController(editVC, animated: true)
            }else{
                print("true")
                AlertSearch().getPasswordAlert(controller: self, currentPassword: passwordforDocumt, index: index, from: "doc", for_using: "password", passwordProtected: true,insideSearching:insideSearching)
            }
        }
    }
}


class AlertSearch{
    
    func getPasswordAlert(controller: SearchViewController, currentPassword:String, index: Int, from: String, for_using:String, passwordProtected: Bool, insideSearching:Bool){
        
        
        
        
        let alertController = UIAlertController(title: "Enter your password", message: nil, preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "OK", style: .default) { (_) in
            if let txtField = alertController.textFields?.first, let text = txtField.text {
                
                // section for folder with Password match for  Option SetPassword
                if (from == "folder" && for_using == "password") {
                    
                    let tempNameFolder = (controller.insideSearching == true) ?  controller.filterSearchData[index].primaryKey ?? "" :  controller.allserarchdata[index].primaryKey ?? ""
                    
                    if text == currentPassword{
                        //print("password match!!!")
                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let newViewController = storyBoard.instantiateViewController(withIdentifier: "folderGalleryVC") as! FolderGalleryVC
                        newViewController.folderName = tempNameFolder
                        
                        controller.navigationController?.pushViewController(newViewController, animated: true)
                    }else{
                        controller.showMessageToUser(title: "Message", msg: "your password is worng try again")
                    }
                    
                }
                
                
                // for document and setpassword option
                else if (from == "doc" && for_using == "password"){
                    
                   let tempNameDoc = (controller.insideSearching == true) ?  controller.filterSearchData[index].name! :  controller.allserarchdata[index].name!
                    //let tempImageDoc = (controller.insideSearching == true) ? controller.filterSearchData[index].image : controller.allserarchdata[index].image
                    let originalImageDoc = (controller.insideSearching == true) ? controller.filterSearchData[index].originalImage : controller.allserarchdata[index].originalImage
                    if text == currentPassword{
                        //print("password match!!!")
                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let editVC = storyBoard.instantiateViewController(withIdentifier: "editVC") as! EditVC
                        editVC.editImage = originalImageDoc
                        editVC.currentDocumentName = tempNameDoc
                        
                        controller.navigationController?.pushViewController(editVC, animated: false)
                    }
                    else{
                        controller.showMessageToUser(title: "Message", msg: "your password is worng try again")
                    }
                    
                }
                //document and rename option calling...
                
                
                // delete for folder
                
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
}
