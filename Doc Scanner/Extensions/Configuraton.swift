//
//  Configuraton.swift
//  Doc Scanner
//
//  Created by LollipopMacbook on 9/2/21.
//

import Foundation
import UIKit

class Extention{
    
     static func designDisplayMood(controller: UIViewController){
        
        if #available(iOS 13.0, *) {

            controller.overrideUserInterfaceStyle = .light
        }
    }
}
