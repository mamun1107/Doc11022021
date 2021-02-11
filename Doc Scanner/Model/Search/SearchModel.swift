//
//  SearchModel.swift
//  Doc Scanner
//
//  Created by LollipopMacbook on 10/2/21.
//

import Foundation
import UIKit


struct AllSearchData {
    
    var name:String?
    var primaryKey:String?
    var image:UIImage
    var totaldoc:String?
    var isSelected = false
    var ispasswordProtected:Bool
    var password:String?
    var originalImage:UIImage
    
    init(name:String,primaryKey:String, image:UIImage, totaldoc:String, ispasswordProtected:Bool, password:String, originalImage:UIImage){
        self.name = name
        self.primaryKey = primaryKey
        self.image = image
        self.totaldoc = totaldoc
        self.ispasswordProtected = ispasswordProtected
        self.password = password
        self.originalImage = originalImage
    }
}
