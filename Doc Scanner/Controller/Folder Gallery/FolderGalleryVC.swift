//
//  FolderGalleryVC.swift
//  Doc Scanner
//
//  Created by Fahim Rahman on 17/1/21.
//

import UIKit
import FMPhotoPicker
import VisionKit


// MARK: - Folder Gallery View Controller

class FolderGalleryVC: UIViewController {
    
    // MARK: - Variables
    
    var folderName: String = String()
    var currentImage: UIImage = UIImage()
    var currentDocumentName: String = String()
    var myDocuments = [Documents]()
    
    var currentCellNumber: Int = 1
    var totalDocuments: Int = Int()
    
    var folderGalleryCollectionView: UICollectionView!
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var topStackView: UIStackView!
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK - View Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setViewCustomColor(view: self.view, color: .white)
        
        self.setFolderGalleryCollectionView()
        
        self.myDocuments.removeAll()
        self.myDocuments = self.readDocumentFromRealm(folderName: self.folderName, sortBy: "documentSize")
        
        self.setCustomNavigationBar(largeTitleColor: .black, backgoundColor: .white, tintColor: .black, title: "\(self.currentCellNumber) / \(self.totalDocuments)", preferredLargeTitle: false)
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Share
    
    @IBAction func sharePressed(_ sender: UIButton) {
        print(#function)
        
        if !self.myDocuments.isEmpty {
            
            let shareVC = UIActivityViewController(activityItems: [self.currentImage], applicationActivities: nil)
                
            self.present(shareVC, animated: true)
        }
        else {
            self.showToast(message: "Empty folder can't be shared", duration: 3.0, position: .bottom)
        }
    }
    
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    
    // MARK: - Signature
    
    @IBAction func signature(_ sender: UIButton) {
        print(#function)
        
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Edit
    
    @IBAction func edit(_ sender: UIButton) {
        print(#function)
        
        if !self.myDocuments.isEmpty {
            
            let config = FMPhotoPickerConfig()
            
            let editor = FMImageEditorViewController(config: config, sourceImage: self.currentImage)
            editor.delegate = self
            
            self.present(editor, animated: true)
        }
    }
    
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    
    // MARK: - Add Scan
    
    @IBAction func addScan(_ sender: UIButton) {
        print(#function)
        
        let vnDocVC = VNDocumentCameraViewController()
        vnDocVC.delegate = self
        present(vnDocVC, animated: false)
    }
}



//-------------------------------------------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------------------------------------------



// MARK: - Folder Gallery Collection View

extension FolderGalleryVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    // MARK: - Number Of Items In Section
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.myDocuments.count
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Cell For Item At
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = folderGalleryCollectionView.dequeueReusableCell(withReuseIdentifier: "folderGalleryCVCell", for: indexPath) as! FolderGalleryCVCell
        
        cell.folderGalleryImageView.image = UIImage(data: self.myDocuments[indexPath.row].documentData ?? Data())
        
        if !self.myDocuments.isEmpty {
            
            self.currentImage = UIImage(data: self.myDocuments[indexPath.row].documentData ?? Data()) ?? UIImage()
            self.currentDocumentName = self.myDocuments[indexPath.row].documentName ?? ""
        }
        
        return self.setFolderGalleryCell(cell: cell)
    }
    
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    
    // MARK: - Collection View Layout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let numberOfCellsInRow = 1
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left + flowLayout.sectionInset.right + (flowLayout.minimumInteritemSpacing * CGFloat(numberOfCellsInRow - 1))
        
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(numberOfCellsInRow))
        
        return CGSize(width: size, height: Int(collectionView.bounds.height))
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Minimum Line Spacing For Section At
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat { return 0 }
    
    
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    
    // MARK: - Scroll View Did End Decelerating
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        for cell in self.folderGalleryCollectionView.visibleCells {
            
            if let row = self.folderGalleryCollectionView.indexPath(for: cell)?.item {
                
                self.currentCellNumber = (row + 1)
                
                self.title = "\(self.currentCellNumber) / \(self.myDocuments.count)"
            }
        }
    }
}



//-------------------------------------------------------------------------------------------------------------------------------------------------



// MARK: - FMPhoto Picker View Controller Delegate

extension FolderGalleryVC: FMImageEditorViewControllerDelegate {
    
    func fmImageEditorViewController(_ editor: FMImageEditorViewController, didFinishEdittingPhotoWith photo: UIImage) {
        
        self.dismiss(animated: false) {
            
            if let imageData = photo.jpegData(compressionQuality: 0.9) {
                
                self.updateDocumentToRealm(folderName: self.folderName, currentDocumentName: self.currentDocumentName, newDocumentName: "DocMod", newDocumentData: imageData, newDocumentSize: Int(imageData.getSizeInMB()))
                
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
}





extension FolderGalleryVC: VNDocumentCameraViewControllerDelegate {
    
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
        
        var rawImages: [UIImage] = [UIImage]()
        
        for pageNumber in 0..<scan.pageCount {
            
            let image = scan.imageOfPage(at: pageNumber)
            rawImages.append(image)
        }
            
            for rawImage in 0..<rawImages.count {
                
                if let imageData = rawImages[rawImage].jpegData(compressionQuality: 0.9) {

                    self.writeDocumentToRealm(folderName: self.folderName, documentName: "Doc", documentData: imageData, documentSize: Int(imageData.getSizeInMB()))
                }
            }

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
