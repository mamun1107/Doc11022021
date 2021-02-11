//
//  FolderGalleryCVCell.swift
//  Doc Scanner
//
//  Created by Fahim Rahman on 17/1/21.
//

import UIKit

// MARK: - Folder Gallery Collection View Cell

class FolderGalleryCVCell: UICollectionViewCell {

    
    // MARK: - Outlets
    
    @IBOutlet weak var folderGalleryImageView: UIImageView!
    
    
    // MARK: - Awake From Nib
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.folderGalleryImageView.contentMode = .scaleAspectFit
    }
}
