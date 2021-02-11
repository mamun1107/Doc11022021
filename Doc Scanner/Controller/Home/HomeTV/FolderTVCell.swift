//
//  FolderTableViewCell.swift
//  Doc Scanner
//
//  Created by Fahim Rahman on 9/1/21.
//

import UIKit

// MARK:- Option Button Protocol

protocol CellDelegateTV: class {
    
    func optionButtonTV(index: Int)
}

// MARK: - Folder Table View Cell

class docsAndFoldsTVCell: UITableViewCell {
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var docsAndFoldsImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberOfItemsLabel: UILabel!
    @IBOutlet weak var optionButton: UIButton!
    
    
    weak var cellDelegate: CellDelegateTV?
    
    // MARK: - Awake From Nib
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Set Selected
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Cell Option Button Action
    
    @IBAction func optionButtonAction(_ sender: UIButton) {
        
        cellDelegate?.optionButtonTV(index: sender.tag)
    }
    
}
