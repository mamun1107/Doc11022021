//
//  FolderGalleryVCHelper.swift
//  Doc Scanner
//
//  Created by Fahim Rahman on 17/1/21.
//

import UIKit

// MARK: - Folder Gallery View Controller Helper

extension FolderGalleryVC {
    
    
    // MARK: - Set Folder Gallery Collection View
    
    func setFolderGalleryCollectionView() {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 25, right: 0)
        layout.scrollDirection = .horizontal
        
        self.folderGalleryCollectionView = UICollectionView(frame: CGRect(x: self.topStackView.frame.minX, y: self.topStackView.frame.height, width: view.frame.width, height: view.frame.height), collectionViewLayout: layout)
        
        self.folderGalleryCollectionView.register(UINib(nibName: "FolderGalleryCVCell", bundle: nil), forCellWithReuseIdentifier: "folderGalleryCVCell")
        
        self.folderGalleryCollectionView.backgroundColor = UIColor(hex: "EEEEEE")
        
        self.folderGalleryCollectionView.delegate = self
        self.folderGalleryCollectionView.dataSource = self
        
        self.folderGalleryCollectionView.showsVerticalScrollIndicator = false
        
        self.folderGalleryCollectionView.allowsMultipleSelection = false
        
        self.folderGalleryCollectionView.isPagingEnabled = true
        
        self.view.addSubview(self.folderGalleryCollectionView)
    }
    
    
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    
    // MARK: -  Set Folder Gallery Cell
    
    func setFolderGalleryCell(cell: UICollectionViewCell) -> UICollectionViewCell {
        
        cell.backgroundColor = .white
        
        return cell
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
}
