//
//  HomeViewController.swift
//  Doc Scanner
//
//  Created by Fahim Rahman on 7/1/21.
//

import UIKit
import VisionKit
import RealmSwift

// MARK: Home VC

class HomeVC: UIViewController {
    
    // MARK: - Variables
    
    var galleryButtonSelected = Bool()
    var folderButtonSelected = Bool()
    
    var docsAndFoldsTableView: UITableView = UITableView()
    var docsAndFoldsCollectionView: UICollectionView!
    
    var myDocuments = [Documents]()
    var myFolders = [Folders]()
    
    var mySelectedFolder = [String]()
    var mySelectedDocument = [String]()
    
    var folderName: String = "Default"
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    var searchImageCollection = [UIImage]()
    
    // MARK: - Outlets
    
    
    @IBOutlet weak var topBarStackView: UIStackView!
    @IBOutlet weak var galleryButton: UIButton!
    @IBOutlet weak var folderButton: UIButton!
    @IBOutlet weak var bottomView: UIView!
    
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: View Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // self.bottomView.isHidden = true
        
        self.galleryButtonSelected = false
        self.folderButtonSelected = true
        
        self.setCustomNavigationBar(largeTitleColor: UIColor.black, backgoundColor: UIColor.white, tintColor: UIColor.black, title: "Library", preferredLargeTitle: true)
        
        self.setViewCustomColor(view: self.view, color: UIColor(hex: "EEEEEE"))
        
        self.setNavigationElements()
        
        self.setGalleryAndFolderButtonColor()
        
        self.setDocumentCollectionView()

        self.docsAndFoldsTableView.tableFooterView = UIView()
        
        self.myDocuments.removeAll()
        
        self.myDocuments = self.readDocumentFromRealm(folderName: self.folderName, sortBy: "documentSize")
        
        //print(self.myDocuments[0].editabledocumentName)
        
        self.myFolders.removeAll()
        
        self.myFolders = self.readFolderFromRealm(sortBy: "folderDateAndTime")
        
       // let realm = try! Realm()
        //print(realm.configuration.fileURL)
    }
    
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    
    // MARK: - View Did Appear
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    
        
        self.setCustomNavigationBar(largeTitleColor: UIColor.black, backgoundColor: UIColor.white, tintColor: UIColor.black, title: "Library", preferredLargeTitle: true)
        
        self.setRefreshTVandCV(tvSortBy: "folderDateAndTime", cvSortBy: "documentSize")
        
        self.showToast(message: "Synced", duration: 1.0, position: .center)
    }
    
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    
    // MARK: - View Will Appear
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("after ")
    
        self.bottomView.setNeedsLayout()
        self.bottomView.layoutIfNeeded()
        self.navigationController?.hidesBottomBarWhenPushed = true
        self.bottomView.setNeedsUpdateConstraints()
        
        self.navigationController?.navigationBar.isHidden = false
        
        
        self.setCustomNavigationBar(largeTitleColor: UIColor.black, backgoundColor: UIColor.white, tintColor: UIColor.black, title: "Library", preferredLargeTitle: true)
        
        self.setRefreshTVandCV(tvSortBy: "folderDateAndTime", cvSortBy: "documentSize")
        
        self.docsAndFoldsTableView.reloadData()
        self.docsAndFoldsCollectionView.reloadData()
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Navigation Settings
    
    @objc func settingsAction() {
        print(#function)
        if let settingVC = self.storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as? SettingsViewController {
            
            self.navigationController?.navigationBar.isHidden = false
            self.navigationController?.pushViewController(settingVC, animated: true)
        }
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Selection
    
    @objc func selection() {
        print(#function)
        
        // MARK: - List Button Selected
        
        //        if !self.docsAndFoldsTableView.isHidden {
        //
        //            self.docsAndFoldsTableView.isEditing = !self.docsAndFoldsTableView.isEditing
        //
        //            if self.docsAndFoldsTableView.isEditing {
        //
        //                self.navigationItem.rightBarButtonItem?.title = "Delete"
        //            }
        //            else {
        //
        //                self.navigationItem.rightBarButtonItem?.title = "Select"
        //
        //                if !mySelectedFolder.isEmpty {
        //
        //                    for deleteFolder in mySelectedFolder {
        //
        //                        self.deleteFolderFromRealm(folderName: deleteFolder)
        //
        //                        self.myFolders.removeAll()
        //                        self.myFolders = self.readFolderFromRealm(sortBy: "folderDateAndTime")
        //                    }
        //
        //                    self.mySelectedFolder.removeAll()
        //
        //                    DispatchQueue.main.async {
        //                        self.docsAndFoldsTableView.reloadData()
        //                    }
        //                }
        //
        //
        //                if !self.mySelectedDocument.isEmpty {
        //
        //                    for deleteDocument in mySelectedDocument {
        //
        //                        self.deleteDocumentFromRealm(documentName: deleteDocument)
        //
        //                        self.myDocuments.removeAll()
        //                        self.myDocuments = self.readDocumentFromRealm(folderName: self.folderName, sortBy: "documentSize")
        //                    }
        //
        //                    self.mySelectedDocument.removeAll()
        //
        //                    DispatchQueue.main.async {
        //                        self.docsAndFoldsTableView.reloadData()
        //                    }
        //                }
        //            }
        //        }
        
        
        
        //-------------------------------------------------------------------------------------------------------------------------------------------------
        
        
        
        // MARK: - Grid Button Selected
        
        if !self.docsAndFoldsCollectionView.isHidden {
            
            self.docsAndFoldsCollectionView.allowsMultipleSelection = !self.docsAndFoldsCollectionView.allowsMultipleSelection
            
            if self.docsAndFoldsCollectionView.allowsMultipleSelection {
                
                self.navigationItem.rightBarButtonItem?.title = "Delete"
            }
            else {
                
                self.navigationItem.rightBarButtonItem?.title = "Select"
                
                //                if !self.mySelectedDocument.isEmpty {
                //                    print(self.mySelectedDocument)
                //                    for deleteDocument in mySelectedDocument {
                //                        print("for loop")
                //                        self.deleteDocumentFromRealm(documentName: deleteDocument)
                //                    }
                //
                //                    self.mySelectedDocument.removeAll()
                //
                //                    //self.myDocuments.removeAll()
                //                    //self.myDocuments = self.readDocumentFromRealm(folderName: self.folderName, sortBy: "documentSize")
                //
                //                    self.setRefreshTVandCV(tvSortBy: "folderDateAndTime", cvSortBy: "documentSize")
                //                    DispatchQueue.main.async {
                //                        print("reload data")
                //                        self.docsAndFoldsCollectionView.reloadData()
                //                    }
                //                }
                
                
                //                if !self.mySelectedFolder.isEmpty {
                //
                //                    for deleteFolder in mySelectedFolder {
                //
                //                        self.deleteFolderFromRealm(folderName: deleteFolder)
                //                    }
                //
                //                    self.mySelectedFolder.removeAll()
                //
                //                    //self.myFolders.removeAll()
                //                    //self.myFolders = self.readFolderFromRealm(sortBy: "folderDateAndTime")
                //
                //                    self.setRefreshTVandCV(tvSortBy: "folderDateAndTime", cvSortBy: "documentSize")
                //                    DispatchQueue.main.async {
                //                        self.docsAndFoldsCollectionView.reloadData()
                //                    }
                //                }
            }
        }
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Add Folder
    
    @IBAction func addFolderPressed(_ sender: UIButton) {
        print(#function)
        if let createFolderVC = self.storyboard?.instantiateViewController(withIdentifier: "createFolderVC") as? CreateFolderVC {
            
            self.navigationController?.present(createFolderVC, animated: true)
        }
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Folders
    
    @IBAction func foldersPressed(_ sender: UIButton) {
        print(#function)
        
        
        if self.folderButtonSelected == true {
            
            self.docsAndFoldsCollectionView.isHidden = true
            self.docsAndFoldsTableView.isHidden = false
            
            self.docsAndFoldsCollectionView.removeFromSuperview()
            
            self.setFolderButtonColor()
            
            self.setFolderTableView()
            
            // when folder button is selected do -
            
            self.myFolders.removeAll()
            self.myFolders = self.readFolderFromRealm(sortBy: "folderDateAndTime")
            
            self.myDocuments.removeAll()
            self.myDocuments = self.readDocumentFromRealm(folderName: folderName, sortBy: "documentSize")
            
            DispatchQueue.main.async {
                self.docsAndFoldsTableView.reloadData()
            }
            
            self.galleryButtonSelected = true
            self.folderButtonSelected = false
            //self.setDocumentCollectionView()
        }
    }
    
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    
    // MARK: - Gallery
    
    @IBAction func galleryPressed(_ sender: UIButton) {
        print(#function)
        
        if self.galleryButtonSelected == true {
            
            self.docsAndFoldsTableView.isHidden = true
            self.docsAndFoldsCollectionView.isHidden = false
            
            self.docsAndFoldsTableView.removeFromSuperview()
            
            self.setGalleryButtonColor()
            
            self.setDocumentCollectionView()
            
            // When gallery button is selected do -
            
            self.myFolders.removeAll()
            self.myFolders = self.readFolderFromRealm(sortBy: "folderDateAndTime")
            
            self.myDocuments.removeAll()
            self.myDocuments = self.readDocumentFromRealm(folderName: folderName, sortBy: "documentSize")
            
            DispatchQueue.main.async {
                self.docsAndFoldsCollectionView.reloadData()
            }
            
            self.galleryButtonSelected = false
            self.folderButtonSelected = true
            //self.setFolderTableView()
        }
    }
    
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Filter
    
    @IBAction func filterPressed(_ sender: UIButton) {
        print(#function)
        
        self.setActionSheet()
        
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Search
    
    @IBAction func searchPressed(_ sender: UIButton) {
        print(#function)
        
        print("search Pressed!!!")
        if let createSearchVC = self.storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController {
            createSearchVC.totalFolders = self.myFolders
            createSearchVC.totalDocuments = self.myDocuments
            
            print("collection", searchImageCollection.count)
           // self.navigationController?.present(createSearchVC, animated: false, completion: nil)
            
            self.navigationController?.pushViewController(createSearchVC, animated: true)
        }
        
//        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
//        alert.modalPresentationStyle = .popover
//
//        alert.overrideUserInterfaceStyle = .light
//
//        let image = UIImage(named: "folder_image")
//        let imageView = UIImageView()
//        imageView.image = image
//        imageView.frame =  CGRect(x: view.frame.midX - (view.frame.midX)/2.0 - 20, y: 18, width: 24, height: 24)
//        alert.view.addSubview(imageView)
//
//        let image1 = UIImage(named: "folder_lock_image")
//        let imageView1 = UIImageView()
//        imageView1.image = image1
//        alert.view.addSubview(imageView1)
//        imageView1.frame = CGRect(x: view.frame.midX - (view.frame.midX)/2.0 - 20, y: 75, width: 24, height: 24)
//
//        let shareExternal = UIAlertAction(title: NSLocalizedString("Share External Link", comment: ""), style: .default) { action in
//            print("hello inside")
//        }
//        let shareInApp = UIAlertAction(title: "Share within", style: .default)   {
//            action in
//            print("hello outside")
//        }
//        alert.view.tintColor = .black
//        alert.addAction(shareInApp)
//        alert.addAction(shareExternal)
//
//        present(alert, animated: true, completion: nil)
        
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Camera
    @IBAction func cameraPressed(_ sender: UIButton) {
        print(#function)
        
        let vnDocVC = VNDocumentCameraViewController()
        vnDocVC.delegate = self
        present(vnDocVC, animated: false)
        
    }
}



//-------------------------------------------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------------------------------------------



// MARK: - Home VC Folder Table View




//-------------------------------------------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------------------------------------------



// MARK: - Document Collection View





//-------------------------------------------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------------------------------------------




// MARK: - VN Document Camera View Controller Delegates

extension HomeVC: VNDocumentCameraViewControllerDelegate {
    
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
        
        var rawImages: [UIImage] = [UIImage]()
        
        for pageNumber in 0..<scan.pageCount {
            
            let image = scan.imageOfPage(at: pageNumber)
            rawImages.append(image)
        }
        
        if scan.pageCount == 1 {
            
            if let imageData = rawImages.first?.jpegData(compressionQuality: 0.9) {
                
                self.writeDocumentToRealm(folderName: self.folderName, documentName: "Doc", documentData: imageData, documentSize: Int(imageData.getSizeInMB()))
            }
        }
        else {
            
            let createdCustomFolderName = "Custom\(Date.getCurrentTime())"
            
            for rawImage in 0..<rawImages.count {
                
                if let imageData = rawImages[rawImage].jpegData(compressionQuality: 0.9) {
                    
                    self.writeFolderToRealm(folderName: createdCustomFolderName)
                    
                    self.writeDocumentToRealm(folderName: createdCustomFolderName, documentName: "Doc", documentData: imageData, documentSize: Int(imageData.getSizeInMB()))
                }
            }
        }
        //edit:
        controller.dismiss(animated: true)
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
        print(error.localizedDescription)
        controller.dismiss(animated: true)
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
        controller.dismiss(animated: true)
    }
}
