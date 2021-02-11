//
//  EditVCHelper.swift
//  Doc Scanner
//
//  Created by Fahim Rahman on 11/1/21.
//

import UIKit

// MARK: -  Edit VC Helper

extension EditVC {
    
    // MARK: - Set Edit Image
    
    func setEditImage(imageView: UIImageView, image: UIImage, contentMode: UIView.ContentMode) {
        
        imageView.contentMode = contentMode
        imageView.image = image
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    // MARK: - Set Customize the navigation bar Edit
    
//    func setNavigationElements() {
//
//        // MARK:- Selection
//
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(done))
//
//    }
    
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    
    // MARK: - Set Image Rotation
    
    func setImageRotation() {
        
        self.rotationCounter += 1
        
        if self.rotationCounter == 1 {
           // print("prinnt1")
            //self.editImageView.image = UIImage(cgImage: self.editImage.cgImage!, scale: 1, orientation: .right)
            self.imageScrollView.set(image:UIImage(cgImage: self.editImage.cgImage!, scale: 1, orientation: .right))
        }
        
        else if self.rotationCounter == 2 {
            //print("prinnt2")
           
            self.imageScrollView.set(image:UIImage(cgImage: self.editImage.cgImage!, scale: 1, orientation: .down))
            
            //self.editImageView.image = UIImage(cgImage: self.editImage.cgImage!, scale: 1, orientation: .down)
        }
        
        else if self.rotationCounter == 3 {
            //print("prinnt3")
            self.imageScrollView.set(image:UIImage(cgImage: self.editImage.cgImage!, scale: 1, orientation: .left))
            
            //self.editImageView.image = UIImage(cgImage: self.editImage.cgImage!, scale: 1, orientation: .left)
        }
        
        else {
           // print("prinnt4")
            
            //self.editImageView.image = UIImage(cgImage: self.editImage.cgImage!, scale: 1, orientation: .up)
            self.imageScrollView.set(image:UIImage(cgImage: self.editImage.cgImage!, scale: 1, orientation: .up))
            
            self.rotationCounter = 0
        }
    }
}
