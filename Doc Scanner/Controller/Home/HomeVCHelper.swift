//
//  HomeVCHelper.swift
//  Doc Scanner
//
//  Created by Fahim Rahman on 7/1/21.
//

import UIKit

// MARK: - Home VC Helper

extension HomeVC: UITextFieldDelegate {
    
    // MARK: - Set Customize the navigation bar home
    
    func setNavigationElements() {
        
        // MARK:- Selection
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Select", style: .plain, target: self, action: #selector(selection))
        
        
        // MARK:- Settings
        var leftNavigationImage = UIImage(named: "settings")
        leftNavigationImage = leftNavigationImage?.withRenderingMode(.alwaysOriginal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: leftNavigationImage, style: .plain, target: self, action: #selector(settingsAction))
    }
    
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Set Gallery and Folder Button Color
    
    func setGalleryAndFolderButtonColor() {
        
        let galaryOriginalImage = UIImage(named: "grid_select_icon_final")
        let galaryTintedImage = galaryOriginalImage?.withRenderingMode(.alwaysTemplate)
        galleryButton.setImage(galaryTintedImage, for: .normal)
        galleryButton.tintColor = .systemBlue
        
        let folderOriginalImage = UIImage(named: "list_deselect_icon_final")
        let folderTintedImage = folderOriginalImage?.withRenderingMode(.alwaysTemplate)
        folderButton.setImage(folderTintedImage, for: .normal)
        folderButton.tintColor = .black
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Set Galary Button Color Change
    
    func setGalleryButtonColor() {
        
        if galleryButtonSelected == true && folderButtonSelected == false {
            
            let galaryOriginalImage = UIImage(named: "grid_select_icon_final")
            let galaryTintedImage = galaryOriginalImage?.withRenderingMode(.alwaysTemplate)
            galleryButton.setImage(galaryTintedImage, for: .normal)
            galleryButton.tintColor = .systemBlue
            
            let folderOriginalImage = UIImage(named: "list_deselect_icon_final")
            let folderTintedImage = folderOriginalImage?.withRenderingMode(.alwaysTemplate)
            folderButton.setImage(folderTintedImage, for: .normal)
            folderButton.tintColor = .black
        }
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Set Folder Button Color Change
    
    func setFolderButtonColor() {
        
        if folderButtonSelected == true && galleryButtonSelected == false {
            
            let folderOriginalImage = UIImage(named: "list_select_icon_final")
            let folderTintedImage = folderOriginalImage?.withRenderingMode(.alwaysTemplate)
            folderButton.setImage(folderTintedImage, for: .normal)
            folderButton.tintColor = .systemBlue
            
            let galaryOriginalImage = UIImage(named: "grid_deselect_icon_final")
            let galaryTintedImage = galaryOriginalImage?.withRenderingMode(.alwaysTemplate)
            galleryButton.setImage(galaryTintedImage, for: .normal)
            galleryButton.tintColor = .black
        }
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Set Folder Table View
    
    func setFolderTableView() {
        
        self.docsAndFoldsTableView.register(UINib(nibName: "FolderTVCell", bundle: nil), forCellReuseIdentifier: "folderCell")
        
        self.docsAndFoldsTableView.frame = CGRect(x: topBarStackView.frame.minX + 10, y: topBarStackView.frame.height, width: view.frame.width - 20, height: (view.frame.height - (bottomView.frame.height)))
        
        self.docsAndFoldsTableView.backgroundColor = UIColor(hex: "EEEEEE")
        
        self.docsAndFoldsTableView.dataSource = self
        self.docsAndFoldsTableView.delegate = self
        
        self.docsAndFoldsTableView.showsVerticalScrollIndicator = false
        
        self.docsAndFoldsTableView.allowsMultipleSelectionDuringEditing = true
        
        self.view.addSubview(self.docsAndFoldsTableView)
        self.view.sendSubviewToBack(self.docsAndFoldsTableView)
    }
    
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Set Folder Table View Cell
    
    func setFolderCell(cell: UITableViewCell) -> UITableViewCell {
        
        let view = UIView()
        view.backgroundColor = UIColor.white
        
        cell.multipleSelectionBackgroundView = view
        cell.backgroundColor = .white
        cell.selectionStyle = .default
        //cell.tintColor = UIColor(hex: "EB5757")
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.5
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        
        return cell
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Set Document Collection View
    
    func setDocumentCollectionView() {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        
        self.docsAndFoldsCollectionView = UICollectionView(frame: CGRect(x: topBarStackView.frame.minX, y: topBarStackView.frame.height, width: view.frame.width, height: view.frame.height - (bottomView.frame.height)), collectionViewLayout: layout)
        
        self.docsAndFoldsCollectionView.register(UINib(nibName: "DocumentCVCell", bundle: nil), forCellWithReuseIdentifier: "documentCell")
        
        self.docsAndFoldsCollectionView.backgroundColor = UIColor(hex: "EEEEEE")
        
        self.docsAndFoldsCollectionView.delegate = self
        self.docsAndFoldsCollectionView.dataSource = self
        
        self.docsAndFoldsCollectionView.showsVerticalScrollIndicator = false
        
        self.docsAndFoldsCollectionView.allowsMultipleSelection = false
        
        self.view.addSubview(self.docsAndFoldsCollectionView)
        self.view.sendSubviewToBack(self.docsAndFoldsCollectionView)
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Set Document Collection View Cell
    
    func setDocumentCell(cell: UICollectionViewCell) -> UICollectionViewCell {
        
        cell.layer.cornerRadius = 10
        
        return cell
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Set Refresh TVandCV
    
    func setRefreshTVandCV(tvSortBy: String, cvSortBy: String) {
        
        self.myFolders.removeAll()
        self.myFolders = self.readFolderFromRealm(sortBy: tvSortBy)
        
        DispatchQueue.main.async {
            self.docsAndFoldsTableView.reloadData()
        }
        
        self.myDocuments.removeAll()
        self.myDocuments = self.readDocumentFromRealm(folderName: self.folderName, sortBy: cvSortBy)
        
        DispatchQueue.main.async {
            self.docsAndFoldsCollectionView.reloadData()
        }
    }
    
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Set Filter Action Sheet
    
    func showSimpleActionSheet(controller: UIViewController) {
        let alert = UIAlertController(title: "Title", message: "Please Select an Option", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Approve", style: .default, handler: { (_) in
            print("User click Approve button")
        }))

        alert.addAction(UIAlertAction(title: "Edit", style: .default, handler: { (_) in
            print("User click Edit button")
        }))

        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (_) in
            print("User click Delete button")
        }))

        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { (_) in
            print("User click Dismiss button")
        }))

        controller.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    func setActionSheet() {
        
        let alert = UIAlertController(title: "", message: "Please Select an Option", preferredStyle: .actionSheet)
        alert.overrideUserInterfaceStyle = .light
        
        alert.addAction(UIAlertAction(title: "Sort by Name", style: .default, handler: { (_) in
            
            self.myFolders.removeAll()
            self.myFolders = self.readFolderFromRealm(sortBy: "folderName")
            
            self.myDocuments.removeAll()
            self.myDocuments = self.readDocumentFromRealm(folderName: self.folderName, sortBy: "documentName")
            
            DispatchQueue.main.async {
                self.docsAndFoldsTableView.reloadData()
                self.docsAndFoldsCollectionView.reloadData()
            }
        }))

        alert.addAction(UIAlertAction(title: "Sort by Date", style: .default, handler: { (_) in
            
            self.myFolders.removeAll()
            self.myFolders = self.readFolderFromRealm(sortBy: "folderDateAndTime")
            
            self.myDocuments.removeAll()
            self.myDocuments = self.readDocumentFromRealm(folderName: self.folderName, sortBy: "documentDateAndTime")
            
            DispatchQueue.main.async {
                self.docsAndFoldsTableView.reloadData()
                self.docsAndFoldsCollectionView.reloadData()
            }
            
        }))

        alert.addAction(UIAlertAction(title: "Sort by Size", style: .default, handler: { (_) in
            
            self.myFolders.removeAll()
            self.myFolders = self.readFolderFromRealm(sortBy: "folderName")
            
            self.myDocuments.removeAll()
            self.myDocuments = self.readDocumentFromRealm(folderName: self.folderName, sortBy: "documentSize")
            
            DispatchQueue.main.async {
                self.docsAndFoldsTableView.reloadData()
                self.docsAndFoldsCollectionView.reloadData()
            }
            
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
            print("User click Dismiss button")
        }))


        self.present(alert, animated: true)
    }
    

    //-------------------------------------------------------------------------------------------------------------------------------------------------
}
