//
//  RealmModel.swift
//  Doc Scanner
//
//  Created by Fahim Rahman on 11/1/21.
//

import UIKit
import RealmSwift

// MARK: - Data Model For Realm Offline Database
//-------------------------------------------- //


// MARK: - Disk
class Disk: Object {
    
    let folders = List<Folders>()
}


//-------------------------------------------------------------------------------------------------------------------------------------------------


// MARK: - Folders
class Folders: Object {
    
    @objc dynamic var folderName: String? = String()
    @objc dynamic var folderDateAndTime: String = String()
    @objc dynamic var isPasswordProtected: Bool = Bool()
    @objc dynamic var password: String? = String()
    @objc dynamic var editablefolderName: String? = String()
    
    override static func primaryKey() -> String? {
        return "folderName"
    }
    
    let documents = List<Documents>()
}


//-------------------------------------------------------------------------------------------------------------------------------------------------


// MARK: - Documents
class Documents: Object {
    
    @objc dynamic var documentData: Data? = nil
    @objc dynamic var documentName: String? = String()
    @objc dynamic var documentDateAndTime: String = String()
    @objc dynamic var documentSize: Int = Int()
    @objc dynamic var isPasswordProtected: Bool = Bool()
    @objc dynamic var password: String? = String()
    @objc dynamic var editabledocumentName: String? = String()
    
    
    override static func primaryKey() -> String? {
        return "documentName"
    }
}



//-------------------------------------------------------------------------------------------------------------------------------------------------
