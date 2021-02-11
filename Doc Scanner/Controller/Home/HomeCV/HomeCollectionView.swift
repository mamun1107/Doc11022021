//
//  HomeCollectionView.swift
//  Doc Scanner
//
//  Created by LollipopMacbook on 8/2/21.
//

import Foundation
import UIKit


extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CellDelegateCV {
    
    
    // MARK: - Number Of Items In Section
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.myFolders.count + self.myDocuments.count
    }
    
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - CV Cell Option Button
    
    func optionButtonCV(index: Int) {
        
        if index < self.myFolders.count {
            Alerts().showOptionActionSheet(controller: self, folderName: self.myFolders[index].folderName ?? "", from: "folder", passwordProtected:self.myFolders[index].isPasswordProtected, index_option:index)
        }
        else {
            print("here it is call for doc...")
            Alerts().showOptionActionSheet(controller: self, folderName: self.myDocuments[index - self.myFolders.count].documentName ?? "",from: "doc", passwordProtected:self.myDocuments[index - self.myFolders.count].isPasswordProtected, index_option:index - self.myFolders.count)
        }
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Cell For Item At
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = docsAndFoldsCollectionView.dequeueReusableCell(withReuseIdentifier: "documentCell", for: indexPath) as! DocsAndFoldsCVCell
        
        cell.cellDelegate = self
      
        if indexPath.row < self.myFolders.count {
            
            if self.myFolders[indexPath.row].isPasswordProtected == true{
                cell.docsAndFoldsImageView.image = UIImage(named: "folder_lock_image")
                
            }else{
                //here changed the image of folder images
                cell.docsAndFoldsImageView.image = UIImage(named: "folder_image")
                
            }
            
            //cell.docsAndFoldsImageView.image = UIImage(named: "folder_image")
            cell.nameLabel.text = self.myFolders[indexPath.row].editablefolderName
            cell.numberOfItemsLabel.text = String(self.myFolders[indexPath.row].documents.count) + " Document(s)"
            
            cell.optionButton.tag = indexPath.row
        }
        else {
            
            if self.myDocuments[indexPath.row - self.myFolders.count].isPasswordProtected == true{
                cell.docsAndFoldsImageView.image = UIImage(named: "file_lock_image")
                
            }else{
                //here changed the image of folder images
                cell.docsAndFoldsImageView.image = UIImage(data: self.myDocuments[indexPath.row - self.myFolders.count].documentData ?? Data())
                
            }
            
            //cell.docsAndFoldsImageView.image = UIImage(data: self.myDocuments[indexPath.row - self.myFolders.count].documentData ?? Data())
            cell.nameLabel.text = self.myDocuments[indexPath.row - self.myFolders.count].editabledocumentName
            cell.numberOfItemsLabel.text = "1 Document"
            
            cell.optionButton.tag = indexPath.row
        }
        
        return self.setDocumentCell(cell: cell)
    }
    
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Collection View Layout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let numberOfCellsInRow = 3
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left + flowLayout.sectionInset.right + (flowLayout.minimumInteritemSpacing * CGFloat(numberOfCellsInRow - 1))
        
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(numberOfCellsInRow))
        
        return CGSize(width: size, height: size + 30)
    }
    
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    
    // MARK: - Did Select Item At
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell : UICollectionViewCell = self.docsAndFoldsCollectionView.cellForItem(at: indexPath)!
        
        cell.backgroundColor = UIColor(hex: "EB5757")
        
        if !self.docsAndFoldsCollectionView.allowsMultipleSelection {
            
            if indexPath.row < self.myFolders.count {
                print("multiple section called!!!")
                
                if self.myFolders[indexPath.row].isPasswordProtected == false {
                    
                    if let folderGalleryVC = self.storyboard?.instantiateViewController(withIdentifier: "folderGalleryVC") as? FolderGalleryVC {
                        
                        folderGalleryVC.folderName = self.myFolders[indexPath.row].folderName!
                        
                        self.navigationController?.pushViewController(folderGalleryVC, animated: false)
                    }
                }
                else {
                    Alerts().showGetPassAlert(controller: self, currentPassword: self.myFolders[indexPath.row].password!, index: indexPath.row, from: "folder", for_using: "password", passwordProtected: true)
                }
            }
            else {
                print("single section called!!!")
                print(indexPath.row - self.myFolders.count)
                if self.myDocuments[indexPath.row - self.myFolders.count].isPasswordProtected == true{
                    print("true")
                    Alerts().showGetPassAlert(controller: self, currentPassword: self.myDocuments[indexPath.row - self.myFolders.count].password!, index: indexPath.row - self.myFolders.count, from: "doc", for_using: "password", passwordProtected: true)
                } else{
                    
                    if let editVC = self.storyboard?.instantiateViewController(withIdentifier: "editVC") as? EditVC {
                        editVC.editImage = UIImage(data: self.myDocuments[indexPath.row - self.myFolders.count].documentData ?? Data()) ?? UIImage()
                        editVC.currentDocumentName = self.myDocuments[indexPath.row - self.myFolders.count].documentName ?? String()
                        
                        self.navigationController?.pushViewController(editVC, animated: true)
                    }
                    
                }
            }
        }
        else {
            
            if indexPath.row < self.myFolders.count {
                
                self.mySelectedFolder.append(self.myFolders[indexPath.row].folderName!)
            }
            else {
                self.mySelectedDocument.append(self.myDocuments[indexPath.row - self.myFolders.count].documentName!)
            }
        }
    }
    
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    
    // MARK: - Did Deselect Item At
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print(#function, indexPath.row)
        
        let cell : UICollectionViewCell = self.docsAndFoldsCollectionView.cellForItem(at: indexPath)!
        cell.backgroundColor = .white
        
        if self.docsAndFoldsCollectionView.allowsMultipleSelection {
            
            if indexPath.row < self.myFolders.count {
                
                self.mySelectedFolder.removeAll(where: { $0 == self.myFolders[indexPath.row].folderName })
                
            }
            else {
                
                self.mySelectedDocument.removeAll(where: { $0 == self.myDocuments[indexPath.row - self.myFolders.count].documentName })
            }
        }
    }
}

