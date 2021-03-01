//
//  InsideFolderTV.swift
//  Doc Scanner
//
//  Created by LollipopMacbook on 20/2/21.
//


import Foundation
import UIKit

extension InsideFolderVC:UITableViewDelegate, UITableViewDataSource{
    
    // MARK: - Number Of Rows In Section
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return 1 }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Number Of Section
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if searching{
            return insideFilterDocuments.count
        }else{
            return insideDocuments.count
        }
        
        
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = docsTableView.dequeueReusableCell(withIdentifier: "folderCell", for: indexPath) as! docsAndFoldsTVCell
        
        cell.cellDelegate = self
        
        if searching{
            
            if self.insideFilterDocuments[indexPath.section].isPasswordProtected == true{
                cell.docsAndFoldsImageView.image = UIImage(named: "file_lock_image")
                
            }else{
                
                cell.docsAndFoldsImageView.image = UIImage(data: self.insideFilterDocuments[indexPath.section].documentData ?? Data())
                
            }
            cell.nameLabel.text = self.insideFilterDocuments[indexPath.section].editabledocumentName ?? ""
            cell.numberOfItemsLabel.text = "1 Document"
            cell.optionButton.tag = indexPath.section
            
        }else{
            if self.insideDocuments[indexPath.section].isPasswordProtected == true{
                cell.docsAndFoldsImageView.image = UIImage(named: "file_lock_image")
                
            }else{
                
                cell.docsAndFoldsImageView.image = UIImage(data: self.insideDocuments[indexPath.section].documentData ?? Data())
                
            }
            cell.nameLabel.text = self.insideDocuments[indexPath.section].editabledocumentName ?? ""
            cell.numberOfItemsLabel.text = "1 Document"
            cell.optionButton.tag = indexPath.section
            
        }
        
 
        return self.setFolderCell(cell: cell)
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(indexPath.section)
        
        if searching{
            // if password protected
            if let editVC = self.storyboard?.instantiateViewController(withIdentifier: "editVC") as? EditVC {
                
                if self.insideFilterDocuments[indexPath.section].isPasswordProtected == false {
                    editVC.editImage = UIImage(data: self.insideFilterDocuments[indexPath.section].documentData ?? Data()) ?? UIImage()
                    editVC.currentDocumentName = self.insideFilterDocuments[indexPath.section].documentName ?? String()
                    self.navigationController?.pushViewController(editVC, animated: true)
                    
                }
                //else not password protected
                else{
                    AleartsInsideFolder().showGetPassAlert(controller: self, currentPassword: self.insideFilterDocuments[indexPath.section].password!, index: indexPath.section, from: "doc", for_using: "password", passwordProtected: true, section: "table")
                    
                }
                
            }//ending  EditVC
            
        }//ending searching section
        
        else{
            //password protected or not protected see all
            if let insider = self.storyboard?.instantiateViewController(withIdentifier: "PageHorizontalVC") as? PageHorizontalVC {
                insider.alldocs = insideDocuments
                insider.itemIndex = indexPath.section
                insider.takePrimaryKey = primaryKeyName
                
           
                self.navigationController?.pushViewController(insider, animated: true)
                
            }//end of VC
        }//end of else
        
        
       // tableView.deselectRow(at: indexPath, animated: true)

//        let fullScreenController = FullScreenSlideshowViewController()
//        fullScreenController.inputs = model.map { $0.inputSource }
//        fullScreenController.initialPage = indexPath.section
//
//        if let cell = tableView.cellForRow(at: indexPath), let imageView = cell.imageView {
//            slideshowTransitioningDelegate = ZoomAnimatedTransitioningDelegate(imageView: imageView, slideshowController: fullScreenController)
//            fullScreenController.modalPresentationStyle = .custom
//            fullScreenController.transitioningDelegate = slideshowTransitioningDelegate
//        }
//
//        fullScreenController.slideshow.currentPageChanged = { [weak self] page in
//            if let cell = tableView.cellForRow(at: IndexPath(row: page, section: 0)), let imageView = cell.imageView {
//                self?.slideshowTransitioningDelegate?.referenceImageView = imageView
//            }
//        }
//
//        present(fullScreenController, animated: true, completion: nil)
    }
        

    
    // MARK: - Height For Row At
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    // MARK: - Height For Header In Section
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    // MARK: - View For Header In Section
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 10))
    }
    
    
}


extension InsideFolderVC{
    
    func setFolderCell(cell: UITableViewCell) -> UITableViewCell {
        
        let view = UIView()
        view.backgroundColor = UIColor.white
        
        cell.multipleSelectionBackgroundView = view
        cell.backgroundColor = .white
        cell.selectionStyle = .default
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.5
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        
        return cell
    }
    
    func setinsideDocumentTableView() {
        readDataforModelDetails()
        
        self.docsTableView.register(UINib(nibName: "FolderTVCell", bundle: nil), forCellReuseIdentifier: "folderCell")
        
        if UIDevice.modelName == "iPhone 7"{
            self.docsTableView.frame = CGRect(x: topBarStackView.frame.minX + 10, y: topBarStackView.frame.height + 70 , width: view.frame.width - 20, height: (view.frame.height - (bottomView.frame.height + 5)))
   
        }else{
            self.docsTableView.frame = CGRect(x: topBarStackView.frame.minX + 10, y: topBarStackView.frame.height + 100, width: view.frame.width - 20, height: (view.frame.height - (self.bottomView.frame.height + 5 )))
        }
        
      
        
        self.docsTableView.backgroundColor = UIColor(hex: "EEEEEE")
        
        self.docsTableView.dataSource = self
        self.docsTableView.delegate = self
        
        self.docsTableView.showsVerticalScrollIndicator = false
        
        self.docsTableView.allowsMultipleSelectionDuringEditing = true
        
        self.view.addSubview(self.docsTableView)
        self.view.sendSubviewToBack(self.docsTableView)
    }
}


extension InsideFolderVC:CellDelegateTV{
    
    func optionButtonTV(index: Int) {
        // print("inside tableView cell", index)
        if searching{
            AleartsInsideFolder().showOptionActionSheet(controller:self, folderName: self.insideFilterDocuments[index].documentName ?? "", from: "doc", passwordProtected:self.insideFilterDocuments[index].isPasswordProtected,index_option:index, section:"table")
        }else{
            AleartsInsideFolder().showOptionActionSheet(controller:self, folderName: self.insideDocuments[index].documentName ?? "", from: "doc", passwordProtected:self.insideDocuments[index].isPasswordProtected,index_option:index, section:"table")
        }
       
    }
}



