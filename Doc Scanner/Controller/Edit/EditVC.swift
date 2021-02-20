//
//  EditVC.swift
//  Doc Scanner
//
//  Created by Fahim Rahman on 11/1/21.
//

import UIKit
import FMPhotoPicker

// MARK: - Edit View Controller

class EditVC: UIViewController {
    
    @IBOutlet weak var editstakView: UIStackView!
    
    // MARK: - Variables
    
    var editImage: UIImage = UIImage()
    var currentDocumentName: String = String()
    var folderName: String = "Default"
    
    var rotationCounter: Int = 0
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var editImageView: UIImageView!
    
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    //scrolling init
    var imageScrollView: ImageScrollView!
    
    
    // MARK: - View Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      //  self.navigationController?.isToolbarHidden = false
        self.navigationController?.hidesBottomBarWhenPushed = true
         
        self.addImageScrollView()
        self.setViewCustomColor(view: self.view, color: UIColor(hex: "EBEBEB"))
        //self.setEditImage(imageView: self.editImageView, image: self.editImage, contentMode: .scaleAspectFit)
        self.imageScrollView.set(image:self.editImage)
        
        self.setCustomNavigationBar(largeTitleColor: UIColor.black, backgoundColor: UIColor.white, tintColor: UIColor.black, title: "", preferredLargeTitle: false)
        
        //self.setNavigationElements()
        //self.editImageView.enableZoom()
    }
    

    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    func addImageScrollView(){
        imageScrollView = ImageScrollView(frame: editImageView.bounds)
        view.addSubview(imageScrollView)
        setupImageScrollView()
 
       // let imagePath = Bundle.main.path(forResource: "autumn", ofType: "jpg")!
        //let image = UIImage(contentsOfFile: imagePath)!
        
        
       
    }
    
    
    
    // MARK: - Done Button
    
//    @objc func done() {
//        print(#function)
//
//    }
    
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    
    // MARK: Share Pressed
    
    @IBAction func sharePressed(_ sender: UIButton) {
        print(#function)
        
        let shareVC = UIActivityViewController(activityItems: [self.editImage], applicationActivities: nil)
        
        self.present(shareVC, animated: true)
    }
    
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    
    // MARK: - Signature Pressed
    
    @IBAction func signaturePressed(_ sender: UIButton) {
        print(#function)
        
    }
    
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    
    // MARK: - Rotate Pressed
    
    @IBAction func rotatePressed(_ sender: UIButton) {
        print(#function)
        
        self.setImageRotation()
    }
    
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    
    // MARK: - Edit Pressed
    
    @IBAction func editPressed(_ sender: UIButton) {
        print(#function)
        
        let config = FMPhotoPickerConfig()
        
        let editor = FMImageEditorViewController(config: config, sourceImage: self.editImage)
        editor.delegate = self
        
        self.present(editor, animated: true)
    }
}



//-------------------------------------------------------------------------------------------------------------------------------------------------



// MARK: - FMPhoto Picker View Controller Delegate

extension EditVC: FMImageEditorViewControllerDelegate {
    
    func fmImageEditorViewController(_ editor: FMImageEditorViewController, didFinishEdittingPhotoWith photo: UIImage) {
        
        self.dismiss(animated: false) {
            
            if let imageData = photo.jpegData(compressionQuality: 0.9) {
                
                self.updateDocumentToRealm(folderName: self.folderName, currentDocumentName: self.currentDocumentName, newDocumentName: "DocMod", newDocumentData: imageData, newDocumentSize: Int(imageData.getSizeInMB()))
                
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
}

extension EditVC{
    
    func setupImageScrollView() {
        imageScrollView.translatesAutoresizingMaskIntoConstraints = false
        imageScrollView.topAnchor.constraint(equalTo: editstakView.bottomAnchor, constant:  15).isActive = true
        imageScrollView.bottomAnchor.constraint(equalTo: editImageView.bottomAnchor).isActive = true
        imageScrollView.trailingAnchor.constraint(equalTo: editImageView.trailingAnchor).isActive = true
        imageScrollView.leadingAnchor.constraint(equalTo: editImageView.leadingAnchor).isActive = true
    }
}
