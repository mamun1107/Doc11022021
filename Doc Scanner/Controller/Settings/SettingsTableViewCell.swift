//
//  SettingsTableViewCell.swift
//  Doc Scanner
//
//  Created by LollipopMacbook on 24/1/21.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    

    @IBOutlet weak var upgradeImageButton: UIButton!
    
    @IBOutlet weak var settingsImage: UIImageView!
    
    @IBOutlet weak var settingsTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    @IBAction func upgradeButtonClicked(_ sender: UIButton) {
        print("clicked upgrade button")
    }
    
}
