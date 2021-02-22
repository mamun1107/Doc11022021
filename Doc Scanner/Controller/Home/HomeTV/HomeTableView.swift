//
//  HomeTableView.swift
//  Doc Scanner
//
//  Created by LollipopMacbook on 8/2/21.
//

import Foundation
import UIKit


extension HomeVC: UITableViewDelegate, UITableViewDataSource, CellDelegateTV {
    
    // MARK: - Number Of Rows In Section
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return 1 }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Number Of Section
    
    func numberOfSections(in tableView: UITableView) -> Int { return self.myFolders.count + self.myDocuments.count }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - TV Cell Option Button
    
    func optionButtonTV(index: Int) {
        //, whichViewController:"Home"
        
        if index < self.myFolders.count {
            Alerts().showOptionActionSheet(controller: self, folderName: self.myFolders[index].folderName ?? "", from: "folder", passwordProtected:self.myFolders[index].isPasswordProtected, index_option:index)
        }
        else {
            Alerts().showOptionActionSheet(controller: self, folderName: self.myDocuments[index - self.myFolders.count].documentName ?? "", from: "doc", passwordProtected:self.myDocuments[index - self.myFolders.count].isPasswordProtected,index_option:index - self.myFolders.count)
        }
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Cell For Row At
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = docsAndFoldsTableView.dequeueReusableCell(withIdentifier: "folderCell", for: indexPath) as! docsAndFoldsTVCell
        
        cell.cellDelegate = self
        
        if indexPath.section < self.myFolders.count {
            
            if self.myFolders[indexPath.section].isPasswordProtected == true{
                cell.docsAndFoldsImageView.image = UIImage(named: "folder_lock_image")
                //searchImageCollection[indexPath.section] = UIImage(named: HomeAsset.folderLockImage)!
                
            }else{
                //here changed the image of folder images
                cell.docsAndFoldsImageView.image = UIImage(named: "folder_image")
                //searchImageCollection[indexPath.section] = UIImage(named: HomeAsset.folderUnlockImage)!
            }
            cell.nameLabel.text = self.myFolders[indexPath.section].editablefolderName ?? ""
            print(self.myFolders[indexPath.section].editablefolderName!)
            cell.numberOfItemsLabel.text = String(self.myFolders[indexPath.section].documents.count) + " Document(s)"
            
            cell.optionButton.tag = indexPath.section
            
            
        }
        
        else {
            
            if self.myDocuments[indexPath.section - self.myFolders.count].isPasswordProtected == true{
                cell.docsAndFoldsImageView.image = UIImage(named: "file_lock_image")
                //searchImageCollection[indexPath.section - self.myFolders.count] = UIImage(named: "file_lock_image")!
                
            }else{
                //here changed the image of folder images
                cell.docsAndFoldsImageView.image = UIImage(data: self.myDocuments[indexPath.section - self.myFolders.count].documentData ?? Data())
                //searchImageCollection[indexPath.section - self.myFolders.count] = UIImage(data: self.myDocuments[indexPath.section - self.myFolders.count].documentData ?? Data())!
                
            }
            cell.nameLabel.text = self.myDocuments[indexPath.section - self.myFolders.count].editabledocumentName ?? ""
            cell.numberOfItemsLabel.text = "1 Document"
            
            cell.optionButton.tag = indexPath.section
        }
        
        return self.setFolderCell(cell: cell)
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Height For Row At
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    // MARK: - Height For Header In Section
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    // MARK: - View For Header In Section
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Did Select Row At
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function, indexPath.section)
        
        if !self.docsAndFoldsTableView.isEditing {
            
            if indexPath.section < self.myFolders.count {
                print("for only folder!! tableView section")
                
                // new editing working ....
                
                if let insideFolderVC = self.storyboard?.instantiateViewController(withIdentifier: "InsideFolderVC") as? InsideFolderVC{
                    
                    if self.myFolders[indexPath.section].isPasswordProtected == false{
                        insideFolderVC.primaryKeyName = self.myFolders[indexPath.section].folderName!
                        insideFolderVC.titleHeader = self.myFolders[indexPath.section].editablefolderName
                        insideFolderVC.listButtonSelected = true
                        insideFolderVC.homeObject = self
                        self.navigationController?.pushViewController(insideFolderVC, animated: true)
                    }
                    
                    else{
                        Alerts().showGetPassAlert(controller: self, currentPassword: self.myFolders[indexPath.section].password!, index: indexPath.section, from: "folder", for_using: "password", passwordProtected: true)
                    }
                    
                }
                
//                if let folderGalleryVC = self.storyboard?.instantiateViewController(withIdentifier: "folderGalleryVC") as? FolderGalleryVC {
//
//                    if self.myFolders[indexPath.section].isPasswordProtected == false {
//
//                        folderGalleryVC.folderName = self.myFolders[indexPath.section].folderName!
//
//                        self.navigationController?.pushViewController(folderGalleryVC, animated: false)
//                    }
//                    else {
//                        print("here it is")
//
//                        Alerts().showGetPassAlert(controller: self, currentPassword: self.myFolders[indexPath.section].password!, index: indexPath.section, from: "folder", for_using: "password", passwordProtected: true)
//
//                    }
//                }
            }
            else {
                
                print("for document tableView Section")
                
                
                
                if let editVC = self.storyboard?.instantiateViewController(withIdentifier: "editVC") as? EditVC {
                    
                    if self.myDocuments[indexPath.section - self.myFolders.count].isPasswordProtected == false {
                        print("false")
                        editVC.editImage = UIImage(data: self.myDocuments[indexPath.section - self.myFolders.count].documentData ?? Data()) ?? UIImage()
                        editVC.currentDocumentName = self.myDocuments[indexPath.section - self.myFolders.count].documentName ?? String()
                        
                        self.navigationController?.pushViewController(editVC, animated: true)
                    }else{
                        print("true")
                        Alerts().showGetPassAlert(controller: self, currentPassword: self.myDocuments[indexPath.section - self.myFolders.count].password!, index: indexPath.section - self.myFolders.count, from: "doc", for_using: "password", passwordProtected: true)
                    }
                    
                    
                    
                }
            }
        }
        else {
            
            if indexPath.section < self.myFolders.count {
                
                self.mySelectedFolder.append(self.myFolders[indexPath.section].folderName!)
            }
            else {
                
                self.mySelectedDocument.append(self.myDocuments[indexPath.section - self.myFolders.count].documentName!)
            }
        }
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Did Deselect Row At
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        print(#function, indexPath.section)
        
        if self.docsAndFoldsTableView.isEditing {
            
            if indexPath.section < self.myFolders.count {
                
                self.mySelectedFolder.removeAll(where: { $0 == self.myFolders[indexPath.section].folderName })
            }
            else {
                
                self.mySelectedDocument.removeAll(where: { $0 == self.myDocuments[indexPath.section - self.myFolders.count].documentName })
            }
        }
    }
}

