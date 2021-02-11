//
//  SettingsHelpers.swift
//  Doc Scanner
//
//  Created by LollipopMacbook on 24/1/21.
//

import Foundation
import UIKit

extension SettingsViewController{
    
    @objc func switchChanged(_ sender : UISwitch!){
        
        print("table row switch Changed \(sender.tag)")
        print("The switch is \(sender.isOn ? "ON" : "OFF")")
    }
}
