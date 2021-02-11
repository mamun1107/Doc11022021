//
//  DocumentCVCell.swift
//  Doc Scanner
//  Created by Fahim Rahman on 9/1/21.

import UIKit
// MARK:- Option Button Protocol

protocol CellDelegateCV: class {
    
    func optionButtonCV(index: Int)
}


// MARK: - Document Collection View Cell

class DocsAndFoldsCVCell: UICollectionViewCell {
    
    // MARK: -  Outlets
    
    @IBOutlet weak var docsAndFoldsImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberOfItemsLabel: UILabel!
    
    @IBOutlet weak var optionButton: UIButton!
    
    weak var cellDelegate: CellDelegateCV?
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Awake From Nib
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Is Selected
    
    override var isSelected: Bool {
        didSet {
            
            self.backgroundColor = isSelected ? UIColor(hex: "EB5757") : UIColor.white
        }
    }
    
    
    
    // MARK:- Option Button Action
    
    @IBAction func optionButtonAction(_ sender: UIButton) {
        
        cellDelegate?.optionButtonCV(index: sender.tag)
    }
}
