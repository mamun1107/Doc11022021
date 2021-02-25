//
//  InsideFolderActionSheet.swift
//  Doc Scanner
//
//  Created by LollipopMacbook on 23/2/21.
//

import Foundation
import UIKit

extension InsideFolderVC{
    
    func setActionSheetforInsideFolder() {
        
        let alert = UIAlertController(title: "", message: "Please Select an Option", preferredStyle: .actionSheet)
        alert.overrideUserInterfaceStyle = .light
        
        alert.addAction(UIAlertAction(title: "Sort by Name", style: .default, handler: { (_) in
            
//            self.myFolders.removeAll()
//            self.myFolders = self.readFolderFromRealm(sortBy: "folderName")
//
//            self.myDocuments.removeAll()
//            self.myDocuments = self.readDocumentFromRealm(folderName: self.folderName, sortBy: "documentName")
//
//            DispatchQueue.main.async {
//                self.docsAndFoldsTableView.reloadData()
//                self.docsAndFoldsCollectionView.reloadData()
//            }
        }))

        alert.addAction(UIAlertAction(title: "Sort by Date", style: .default, handler: { (_) in
            
//            self.myFolders.removeAll()
//            self.myFolders = self.readFolderFromRealm(sortBy: "folderDateAndTime")
//
//            self.myDocuments.removeAll()
//            self.myDocuments = self.readDocumentFromRealm(folderName: self.folderName, sortBy: "documentDateAndTime")
//
//            DispatchQueue.main.async {
//                self.docsAndFoldsTableView.reloadData()
//                self.docsAndFoldsCollectionView.reloadData()
//            }
            
        }))

        alert.addAction(UIAlertAction(title: "Sort by Size", style: .default, handler: { (_) in
            
//            self.myFolders.removeAll()
//            self.myFolders = self.readFolderFromRealm(sortBy: "folderName")
//            
//            self.myDocuments.removeAll()
//            self.myDocuments = self.readDocumentFromRealm(folderName: self.folderName, sortBy: "documentSize")
//            
//            DispatchQueue.main.async {
//                self.docsAndFoldsTableView.reloadData()
//                self.docsAndFoldsCollectionView.reloadData()
//            }
            
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
            print("User click Dismiss button")
        }))


        self.present(alert, animated: true)
    }
    
}
