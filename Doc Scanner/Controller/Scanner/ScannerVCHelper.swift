////
////  ScannerVCHelper.swift
////  Doc Scanner
////
////  Created by Fahim Rahman on 8/1/21.
////
//
//import UIKit
//import AVFoundation
//import CropViewController
//
//// MARK: -  Scannner VC Helper
//
//extension ScannerVC: CropViewControllerDelegate {
//
//
//    // MARK: - Set Toggle Flashlight
//
//    func setToggleFlashlight(on: Bool) {
//
//        guard let device = AVCaptureDevice.default(for: .video) else { return }
//
//        if device.hasTorch {
//            do {
//                try device.lockForConfiguration()
//
//                on ?
//                    (device.torchMode = .on) :
//                    (device.torchMode = .off)
//                on ?
//                    (self.flashLight.setImage(UIImage(named: "flashSelected"), for: .normal)) :
//                    (self.flashLight.setImage(UIImage(named: "flash"), for: .normal))
//
//                device.unlockForConfiguration()
//
//            } catch { print(#function) }
//        }
//    }
//
//
//    //-------------------------------------------------------------------------------------------------------------------------------------------------
//
//
//    // MARK: - Set Single Button Color
//
//    func setSingleButtonColor() {
//
//        self.singleButtonSelected ?
//            self.singleButton.setImage(UIImage(named: "singleScanSelected"), for: .normal) :
//            self.singleButton.setImage(UIImage(named: "singleScan"), for: .normal)
//    }
//
//
//    //-------------------------------------------------------------------------------------------------------------------------------------------------
//
//
//    // MARK: - Set Batch Button Color
//
//    func setBatchButtonColor() {
//
//        self.batchButtonSelected ?
//            self.batchButton.setImage(UIImage(named: "batchScanSelected"), for: .normal) :
//            self.batchButton.setImage(UIImage(named: "batchScan"), for: .normal)
//    }
//
//
//    //-------------------------------------------------------------------------------------------------------------------------------------------------
//
//
//    // MARK: - Set Camera Preview
//
//    func setCameraPreview() {
//
//        guard let captureDevice = AVCaptureDevice.default(for: AVMediaType.video) else { return }
//
//        do {
//            // Get an instance of the AVCaptureDeviceInput class using the previous deivce object
//            let input = try AVCaptureDeviceInput(device: captureDevice)
//
//            // Set focus configuration
//            if input.device.isFocusModeSupported(AVCaptureDevice.FocusMode.autoFocus) {
//
//                do {
//                    try input.device.lockForConfiguration()
//                    input.device.isSmoothAutoFocusEnabled = true
//                    input.device.focusMode = .continuousAutoFocus
//                    input.device.unlockForConfiguration()
//                } catch {
//                    print(error.localizedDescription)
//                }
//            }
//
//            // Initialize the captureSession object
//            captureSession = AVCaptureSession()
//
//            // Set the input devcie on the capture session
//            captureSession?.addInput(input)
//
//            // Get an instance of ACCapturePhotoOutput class
//            capturePhotoOutput = AVCapturePhotoOutput()
//            capturePhotoOutput?.isHighResolutionCaptureEnabled = true
//
//            // Set the output on the capture session
//            captureSession?.addOutput(capturePhotoOutput!)
//
//            // Initialize a AVCaptureMetadataOutput object and set it as the input device
//            let captureMetadataOutput = AVCaptureMetadataOutput()
//            captureSession?.addOutput(captureMetadataOutput)
//
//            //Initialise the video preview layer and add it as a sublayer to the viewPreview view's layer
//            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
//            videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
//            videoPreviewLayer?.connection?.videoOrientation = .portrait
//
//
//            DispatchQueue.main.async {
//                self.videoPreviewLayer?.frame = self.cameraView.layer.bounds
//            }
//
//            self.cameraView.layer.insertSublayer(videoPreviewLayer!, at: 0)
//
//            //start video capture
//            DispatchQueue.global(qos: .userInitiated).async {
//                self.captureSession?.startRunning()
//            }
//
//        } catch {
//
//            //If any error occurs, simply print it out
//            print(error.localizedDescription)
//            return
//        }
//    }
//
//
//
//    //-------------------------------------------------------------------------------------------------------------------------------------------------
//
//
//
//    // MARK: - Set Crop
//
//    func setCrop() {
//
//        if imageToBeCropped != nil {
//
//            let cropController = CropViewController(croppingStyle: croppingStyle, image: imageToBeCropped!)
//            cropController.delegate = self
//
//            self.present(cropController, animated: true, completion: nil)
//        }
//    }
//}
