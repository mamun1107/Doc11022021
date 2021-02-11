//
//  SettingsViewController.swift
//  Doc Scanner
//
//  Created by LollipopMacbook on 24/1/21.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var settingsTableView: UITableView!
    
    // These strings will be the data for the table view cells
    let settngsTexts: [String] = ["Upgrade to Premium", "Restore", "Rating", "Share", "Support", "More app", "Terms & Privacy", "FAQ"]
    
    let settingImagesNames = ["icon","restore_settings","heart_settings","share_settings","support_settings","moreapps_settings","terms_privecy_settings","faq_settings"]
    
    let cellReuseIdentifier = "cell"
    let cellSpacingHeight: CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            // Always adopt a light interface style.
            overrideUserInterfaceStyle = .light
        }
        self.setCustomNavigationBar(largeTitleColor: UIColor.black, backgoundColor: UIColor.white, tintColor: UIColor.black, title: "Settings", preferredLargeTitle: true)
        
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
        //section for not showing tableView separation
        self.settingsTableView.tableFooterView = UIView()
        self.settingsTableView.estimatedRowHeight = 80
        
        
    }
    
    
    
}


extension SettingsViewController:UITableViewDelegate, UITableViewDataSource{
    // MARK: - Table View delegate methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.settngsTexts.count
    }
    
    // There is just one row in every section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    // Make the background color show through
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SettingsTableViewCell
        cell.textLabel?.font = UIFont(name: "Roboto", size: 21)
        
        if indexPath.section == 0{

            cell.backgroundColor = .systemBlue
            cell.settingsTitle.textColor = .white
            cell.accessoryType = .none
            cell.upgradeImageButton.isHidden = false

            
            
        }
//        else if indexPath.section == 4{
//            cell.accessoryType = .none
//            let switchView = UISwitch(frame: .zero)
//            switchView.setOn(true, animated: true)
//            switchView.tag = indexPath.section
//            switchView.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
//            cell.accessoryView = switchView
//            cell.upgradeImageButton.isHidden = true
//
//        }
        else{
            cell.accessoryType = .disclosureIndicator
            cell.upgradeImageButton.isHidden = true
        }
        
        cell.settingsTitle.text = self.settngsTexts[indexPath.section]
        cell.settingsImage.image = UIImage(named: self.settingImagesNames[indexPath.section])
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.5
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // note that indexPath.section is used rather than indexPath.row
        print("You tapped cell number \(indexPath.section).")
    }
}


