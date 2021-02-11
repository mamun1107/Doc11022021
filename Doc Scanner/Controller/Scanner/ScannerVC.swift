////
////  ScannerViewController.swift
////  Doc Scanner
////  Created by Fahim Rahman on 8/1/21.
//
//import UIKit
//import AVFoundation
//import CropViewController
//import RealmSwift
//
//// MARK: - Scanner VC
//
//class ScannerVC: UIViewController {
//    
//    // MARK: - Variables
//    
//    var captureSession: AVCaptureSession?
//    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
//    var capturePhotoOutput: AVCapturePhotoOutput?
//    
//    var flashButtonSelected: Bool = false
//    var singleButtonSelected: Bool = true
//    var batchButtonSelected: Bool = false
//    
//    var imageToBeCropped: UIImage?
//    var folderName: String = "Default"
//    var croppingStyle = CropViewCroppingStyle.default
//    var croppedRect = CGRect.zero
//    var croppedAngle = 0
//    
//    
//    //-------------------------------------------------------------------------------------------------------------------------------------------------
//    
//    
//    // MARK: - Outlets
//    
//    @IBOutlet weak var cameraView: UIView!
//    @IBOutlet weak var flashLight: UIButton!
//    @IBOutlet weak var singleButton: UIButton!
//    @IBOutlet weak var batchButton: UIButton!
//    
//    
//    // MARK: View Did Load
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        self.setViewCustomColor(view: self.view, color: .white)
//        self.setViewCustomColor(view: self.cameraView, color: .black)
//        
//        self.setCameraPreview()
//        self.setSingleButtonColor()
//        self.setBatchButtonColor()
//    }
//    
//    
//    
//    //-------------------------------------------------------------------------------------------------------------------------------------------------
//    
//    
//    // MARK: - View Did Appear
//    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(true)
//        self.captureSession?.startRunning()
//    }
//    
//    
//    
//    //-------------------------------------------------------------------------------------------------------------------------------------------------
//    
//    
//    
//    // MARK: - View Will Disappear
//    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        
//        self.captureSession?.stopRunning()
//    }
//    
//    
//    //-------------------------------------------------------------------------------------------------------------------------------------------------
//    
//    
//    // MARK: - Cancel 
//    
//    @IBAction func cancelPressed(_ sender: UIButton) {
//        print(#function)
//        
//        self.captureSession?.stopRunning()
//        self.navigationController?.popToRootViewController(animated: false)
//    }
//    
//    
//    //-------------------------------------------------------------------------------------------------------------------------------------------------
//    
//    
//    // MARK: - Single
//    
//    @IBAction func singlePressed(_ sender: UIButton) {
//        print(#function)
//        
//        self.singleButtonSelected = true
//        self.batchButtonSelected = false
//        
//        self.setSingleButtonColor()
//        self.setBatchButtonColor()
//        
//    }
//    
//    
//    //-------------------------------------------------------------------------------------------------------------------------------------------------
//    
//    
//    // MARK: - Batch
//    
//    @IBAction func batchPressed(_ sender: UIButton) {
//        print(#function)
//        
//        self.singleButtonSelected = false
//        self.batchButtonSelected = true
//        
//        self.setSingleButtonColor()
//        self.setBatchButtonColor()
//    }
//    
//    
//    //-------------------------------------------------------------------------------------------------------------------------------------------------
//    
//    
//    // MARK: - Flash
//    
//    @IBAction func flashPressed(_ sender: UIButton) {
//        print(#function)
//        
//        self.flashButtonSelected = !self.flashButtonSelected
//        setToggleFlashlight(on: self.flashButtonSelected)
//    }
//    
//    
//    //-------------------------------------------------------------------------------------------------------------------------------------------------
//    
//    
//    // MARK: - Scan
//    
//    @IBAction func scanPressed(_ sender: UIButton) {
//        print(#function)
//        
//        guard let capturePhotoOutput = self.capturePhotoOutput else { return }
//        
//        let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
//        
//        settings.flashMode = .off
//        settings.isHighResolutionPhotoEnabled = true
//        
//        capturePhotoOutput.capturePhoto(with: settings, delegate: self)
//    }
//}
//
//
////-------------------------------------------------------------------------------------------------------------------------------------------------
//
//
//// MARK: - Scanned Photo Processing
//
//extension ScannerVC: AVCapturePhotoCaptureDelegate {
//    
//    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
//        
//        guard let imageData = photo.fileDataRepresentation()
//        else { return }
//        
//        if let rawImage = UIImage(data: imageData) {
//            
//            self.dismiss(animated: false) {
//                
//                self.imageToBeCropped = rawImage
//                self.setCrop()
//            }
//        }
//    }
//}
//
//
//
////-------------------------------------------------------------------------------------------------------------------------------------------------
//
//
//
//// MARK: - Crop Delegates
//
//extension ScannerVC {
//    
//    // MARK: - Did Crop To Image
//    
//    public func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
//        
//        self.croppedRect = cropRect
//        self.croppedAngle = angle
//        
//        if let imageData = image.jpegData(compressionQuality: 0.9) {
//            
//            self.writeDocumentToRealm(folderName: self.folderName, documentName: "Doc", documentData: imageData, documentSize: Int(imageData.getSizeInMB()))
//            
//            if batchButtonSelected {
//            
//                self.showToast(message: "Document Saved", duration: 3.0, position: .bottom)
//                cropViewController.dismiss(animated: true, completion: nil)
//            }
//            else {
//                
//                cropViewController.dismiss(animated: true, completion: nil)
//                self.navigationController?.popToRootViewController(animated: false)
//            }
//        }
//    }
//}
