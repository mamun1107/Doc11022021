//
//  InsideScanVC.swift
//  Doc Scanner
//
//  Created by LollipopMacbook on 23/2/21.
//

import Foundation
import UIKit
import VisionKit

extension InsideFolderVC: VNDocumentCameraViewControllerDelegate {
    
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
        
        var rawImages: [UIImage] = [UIImage]()
        
        for pageNumber in 0..<scan.pageCount {
            
            let image = scan.imageOfPage(at: pageNumber)
            rawImages.append(image)
        }
            
            for rawImage in 0..<rawImages.count {
                
                if let imageData = rawImages[rawImage].jpegData(compressionQuality: 0.9) {
                    
                    guard let primaryKey = self.primaryKeyName else {return}

                    self.writeDocumentToRealm(folderName: primaryKey, documentName: "Doc", documentData: imageData, documentSize: Int(imageData.getSizeInMB()))
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









