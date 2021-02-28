//
//  InsideFolderActionSheet.swift
//  Doc Scanner
//
//  Created by LollipopMacbook on 23/2/21.
//

import Foundation
import UIKit
import RealmSwift

extension InsideFolderVC{
    
    func setActionSheetforInsideFolder() {
        
        let alert = UIAlertController(title: "", message: "Please Select an Option", preferredStyle: .actionSheet)
        alert.overrideUserInterfaceStyle = .light
        
        alert.addAction(UIAlertAction(title: "Sort by Name", style: .default, handler: { (_) in
            guard let primaryKey = self.primaryKeyName else {return}
            
            self.insideDocuments.removeAll()
            self.insideDocuments = self.readDocumentFromRealmForName(folderName:primaryKey, sortBy: "editabledocumentName")
            self.refreshTVandCVDynamicly()
            
        }))
        
        alert.addAction(UIAlertAction(title: "Sort by Date", style: .default, handler: { (_) in
            
            guard let primaryKey = self.primaryKeyName else {return}
            
            self.insideDocuments.removeAll()
            self.insideDocuments = self.readDocumentFromRealm(folderName:primaryKey, sortBy: "documentDateAndTime")
            self.refreshTVandCVDynamicly()
            

        }))
        
        alert.addAction(UIAlertAction(title: "Sort by Size", style: .default, handler: { (_) in
            
            guard let primaryKey = self.primaryKeyName else {return}
            
            self.insideDocuments.removeAll()
            self.insideDocuments = self.readDocumentFromRealm(folderName:primaryKey, sortBy: "documentSize")
            self.refreshTVandCVDynamicly()
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
            print("User click Dismiss button")
        }))
        
        
        self.present(alert, animated: true)
    }
    
}


extension UIViewController{
    
    func readDocumentFromRealmForName(folderName: String, sortBy: String) -> [Documents] {
        
        let realm = try! Realm() // realm object
        var myDocuments = [Documents]()
        
        let folders = realm.objects(Folders.self).filter("folderName == '\(folderName)'")
        print(folders[0].editablefolderName!)
        
        for folder in folders {
            
            for document in folder.documents.sorted(byKeyPath: sortBy, ascending: true) {
                
                myDocuments.append(document)
            }
        }
        return myDocuments
    }
}
