//
//  PageHorizontalVC.swift
//  Doc Scanner
//
//  Created by LollipopMacbook on 28/2/21.
//

import UIKit
//import FMPhotoPicker
//import PagedHorizontalView

class PageHorizontalVC: UIViewController {
    
    @IBOutlet weak var horizontalView: PagedHorizontalView!
    var imageScrollView: ImageScrollView!
    
    var alldocs = [Documents]()
    var itemIndex:Int = 0
    var rotationCounter: Int = 0
    
    var takePrimaryKey:String?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViewCustomColor(view: self.horizontalView, color: UIColor(hex: "EEEEEE"))
        self.horizontalView.collectionView.backgroundColor = UIColor(hex:"EEEEEE")
        horizontalView.tempIndex = itemIndex

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //print("hello")
        self.alldocs.removeAll()
        guard let primaryKey = self.takePrimaryKey else {return}
        self.alldocs = self.readDocumentFromRealmForName(folderName: primaryKey, sortBy: "editabledocumentName")
        DispatchQueue.main.async {
            self.horizontalView.collectionView.reloadData()
            //self.horizontalView.reloadInputViews()
        }
        
    }
  
    @IBAction func editbuttonclicked(_ sender: UIButton) {
        print(horizontalView.tempIndex)
        if self.alldocs[horizontalView.tempIndex].isPasswordProtected == true{
            showMessageToUser(title: "Alert", msg: "File is password protected")
        }else{
            let editImage:UIImage = UIImage(data: self.alldocs[horizontalView.tempIndex].documentData ?? Data()) ?? UIImage()
            let config = FMPhotoPickerConfig()
            
            let editor = FMImageEditorViewController(config: config, sourceImage: editImage)
            editor.delegate = self
            
            self.present(editor, animated: true)
        }
        
    }

    
    
    @IBAction func deleteButtonClicked(_ sender: UIButton) {
        
        if self.alldocs[horizontalView.tempIndex].isPasswordProtected == true{
            showMessageToUser(title: "Alert", msg: "File is password protected")
        }else{
            UIViewController().deleteInsidePagehorizontalDocumentFromRealm(documentName: self.alldocs[horizontalView.tempIndex].documentName!, controller: self)
        }

    }
    
    
    @IBAction func signitureButtonClicked(_ sender: UIButton) {
        print("Nothing..")
    }
    
    
    @IBAction func shareButtonClicked(_ sender: UIButton) {
        let shareImage:UIImage = UIImage(data: self.alldocs[horizontalView.tempIndex].documentData ?? Data()) ?? UIImage()
        let shareVC = UIActivityViewController(activityItems: [shareImage], applicationActivities: nil)
        self.present(shareVC, animated: true)
    }
    
}

extension PageHorizontalVC : UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return alldocs.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PageCvCell
        if self.alldocs[indexPath.row].isPasswordProtected == true{
            cell.imageView.image = UIImage(named: "file_lock_image")
        }else{
            let item = alldocs[(indexPath as NSIndexPath).item]
            cell.imageView.image = UIImage(data: item.documentData ?? Data())
        }
        
        return cell
    }
}



extension PageHorizontalVC:FMImageEditorViewControllerDelegate {
    
    
    func fmImageEditorViewController(_ editor: FMImageEditorViewController, didFinishEdittingPhotoWith photo: UIImage) {
        
        self.dismiss(animated: false) { [self] in
            
            if let imageData = photo.jpegData(compressionQuality: 0.9) {
                
                guard let filenameKey = self.takePrimaryKey else {return}
                
                self.updateDocumentToRealm(folderName: filenameKey, currentDocumentName: self.alldocs[horizontalView.tempIndex].documentName!, newDocumentName: "DocMod", newDocumentData: imageData, newDocumentSize: Int(imageData.getSizeInMB()))
                
                //self.navigationController?.popToRootViewController(animated: true)
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
}
