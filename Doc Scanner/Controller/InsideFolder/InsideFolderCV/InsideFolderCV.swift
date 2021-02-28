//
//  InsideFolderCV.swift
//  Doc Scanner
//
//  Created by LollipopMacbook on 20/2/21.
//

import Foundation
import UIKit


extension InsideFolderVC : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searching{
            return insideFilterDocuments.count
        }else{
            return insideDocuments.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = docsCollectionView.dequeueReusableCell(withReuseIdentifier: "documentCell", for: indexPath) as! DocsAndFoldsCVCell
        
        cell.cellDelegate = self
        
        if searching{
            if self.insideFilterDocuments[indexPath.row].isPasswordProtected == true{
                cell.docsAndFoldsImageView.image = UIImage(named: "file_lock_image")
                
            }else{
                //here changed the image of folder images
                cell.docsAndFoldsImageView.image = UIImage(data: self.insideFilterDocuments[indexPath.row].documentData ?? Data())
                
            }
            cell.nameLabel.text = self.insideFilterDocuments[indexPath.row ].editabledocumentName
            cell.numberOfItemsLabel.text = "1 Document"
            
            cell.optionButton.tag = indexPath.row
            
        }else{
            
            
            if self.insideDocuments[indexPath.row].isPasswordProtected == true{
                cell.docsAndFoldsImageView.image = UIImage(named: "file_lock_image")
                
            }else{
                //here changed the image of folder images
                cell.docsAndFoldsImageView.image = UIImage(data: self.insideDocuments[indexPath.row].documentData ?? Data())
                
            }
            cell.nameLabel.text = self.insideDocuments[indexPath.row ].editabledocumentName
            cell.numberOfItemsLabel.text = "1 Document"
            
            cell.optionButton.tag = indexPath.row
        }
        
        
        return self.setDocumentCell(cell: cell)
        
    }
    
    //collection did select method
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        
        if searching{
            // if password protected
            if let editVC = self.storyboard?.instantiateViewController(withIdentifier: "editVC") as? EditVC {
                
                if self.insideFilterDocuments[indexPath.row].isPasswordProtected == false {
                    editVC.editImage = UIImage(data: self.insideFilterDocuments[indexPath.row].documentData ?? Data()) ?? UIImage()
                    editVC.currentDocumentName = self.insideFilterDocuments[indexPath.row].documentName ?? String()
                    self.navigationController?.pushViewController(editVC, animated: true)
                    
                }
                //else not password protected
                else{
                    AleartsInsideFolder().showGetPassAlert(controller: self, currentPassword: self.insideFilterDocuments[indexPath.row].password!, index: indexPath.row, from: "doc", for_using: "password", passwordProtected: true, section: "collection")
                    
                }
                
            }//ending  EditVC
            
        }//ending searching section
        
        //if not searching
        else{
            
        }//end of all section
        
        
        //collectionView.deselectRow(at: indexPath, animated: true)
//        if let fullScreenController = self.storyboard?.instantiateViewController(withIdentifier: "FullScreenSlideshowViewController") as? FullScreenSlideshowViewController {
//        let fullScreenController = FullScreenSlideshowViewController()
//            fullScreenController.inputs = model.map { $0.inputSource }
//            fullScreenController.initialPage = indexPath.row
//        let cell = docsCollectionView.dequeueReusableCell(withReuseIdentifier: "documentCell", for: indexPath) as! DocsAndFoldsCVCell
//        //
//        slideshowTransitioningDelegate = ZoomAnimatedTransitioningDelegate(imageView: cell.docsAndFoldsImageView, slideshowController: fullScreenController)
//                fullScreenController.modalPresentationStyle = .custom
//                fullScreenController.transitioningDelegate = slideshowTransitioningDelegate
//            //}
//
////            fullScreenController.slideshow.currentPageChanged = { [weak self] page in
////                if let cell = tableView.cellForRow(at: IndexPath(row: page, section: 0)), let imageView = cell.imageView {
////                    self?.slideshowTransitioningDelegate?.referenceImageView = imageView
////                }
////            }
//            present(fullScreenController, animated: false, completion: nil)
        
}
    
    
    
    // MARK: - Collection View Layout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let numberOfCellsInRow = 3
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left + flowLayout.sectionInset.right + (flowLayout.minimumInteritemSpacing * CGFloat(numberOfCellsInRow - 1))
        
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(numberOfCellsInRow))
        
        return CGSize(width: size, height: size + 30)
    }
    
    
}


extension InsideFolderVC{
    
    // MARK: - Set Document Collection View Cell
    
    func setDocumentCell(cell: UICollectionViewCell) -> UICollectionViewCell {
        
        cell.layer.cornerRadius = 10
        
        return cell
    }
    
    func setDocumentCollectionView() {

        readDataforModelDetails()
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        layout.sectionInset = UIEdgeInsets(top: 70, left: 15, bottom: 15, right: 15)
        
        self.docsCollectionView = UICollectionView(frame: CGRect(x: topBarStackView.frame.minX, y: topBarStackView.frame.height, width: view.frame.width, height: view.frame.height ), collectionViewLayout: layout)
        
        self.docsCollectionView.register(UINib(nibName: "DocumentCVCell", bundle: nil), forCellWithReuseIdentifier: "documentCell")
        
        self.docsCollectionView.backgroundColor = UIColor(hex: "EEEEEE")
        
        self.docsCollectionView.delegate = self
        self.docsCollectionView.dataSource = self
        
        self.docsCollectionView.showsVerticalScrollIndicator = false
        
        self.docsCollectionView.allowsMultipleSelection = false
        
        self.view.addSubview(self.docsCollectionView)
        self.view.sendSubviewToBack(self.docsCollectionView)
    }
    
    
}


extension InsideFolderVC:CellDelegateCV{
    //insideFilterDocuments
    func optionButtonCV(index: Int) {
        if searching{
            AleartsInsideFolder().showOptionActionSheet(controller:self, folderName: self.insideFilterDocuments[index].documentName ?? "", from: "doc", passwordProtected:self.insideFilterDocuments[index].isPasswordProtected,index_option:index, section:"collection")
        }else{
            AleartsInsideFolder().showOptionActionSheet(controller:self, folderName: self.insideDocuments[index].documentName ?? "", from: "doc", passwordProtected:self.insideDocuments[index].isPasswordProtected,index_option:index, section:"collection")
        }
    }
}
