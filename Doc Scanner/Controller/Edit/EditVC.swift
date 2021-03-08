//
//  EditVC.swift
//  Doc Scanner
//
//  Created by Fahim Rahman on 11/1/21.
//

import UIKit
//import FMPhotoPicker


extension UIView {
    func toImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)

        drawHierarchy(in: self.bounds, afterScreenUpdates: true)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

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
        
      //self.navigationController?.isToolbarHidden = false
        self.navigationController?.hidesBottomBarWhenPushed = true
        self.addImageScrollView()
       // self.setViewCustomColor(view: self.view, color: UIColor(hex: "EBEBEB"))
        //self.setEditImage(imageView: self.editImageView, image: self.editImage, contentMode: .scaleAspectFit)
        self.imageScrollView.set(image:self.editImage)
        
       // self.setCustomNavigationBar(largeTitleColor: UIColor.black, backgoundColor: UIColor.white, tintColor: UIColor.black, title: "", preferredLargeTitle: false)
        
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
    
    
  

    //MARK: - Save Image callback

  
    
    
    
    // MARK: Share Pressed
    
    @IBAction func sharePressed(_ sender: UIButton) {
        
        
        if let createSearchVC = self.storyboard?.instantiateViewController(withIdentifier: "EditViewController") as? EditViewController {
           // createSearchVC.totalFolders = self.myFolders
           // createSearchVC.totalDocuments = self.myDocuments
   
            //let transition = CATransition()
            //transition.duration = 0.6
           // transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.default)
            //transition.type = CATransitionType.moveIn
            //transition.subtype = CATransitionSubtype.fromTop
            //navigationController?.view.layer.add(transition, forKey: nil)
            createSearchVC.editImage = self.editImage
            
            self.navigationController?.pushViewController(createSearchVC, animated: false)
        }
        
        // pdf create done
        //let data = createPDFDataFromImage(image:self.editImage)
//        let borderWidth: CGFloat = 100.0
//        let myImage = self.editImage
//        let internalPrintView = UIImageView(frame: CGRect(x: 0, y: 0, width: myImage.size.width, height: myImage.size.height))
//        let printView = UIView(frame: CGRect(x: 0, y: 0, width: myImage.size.width + borderWidth*2, height: myImage.size.height + borderWidth*2))
//        internalPrintView.image = myImage
//        internalPrintView.center = CGPoint(x: printView.frame.size.width/2, y: printView.frame.size.height/2)
//        printView.addSubview(internalPrintView)
       // printController.printingItem = printView.toImage()
        
        // print(data)
        
        // image save done
        
        //guard let selectedImage = self.editImage else {return}
        
        //UIImageWriteToSavedPhotosAlbum(self.editImage, self, #selector(imageSave(_:didFinishSavingWithError:contextInfo:)), nil)
        
        
        // print done
        
        //        let printController = UIPrintInteractionController.shared
        //
        //        let printInfo = UIPrintInfo(dictionary: nil)
        //
        //        printInfo.jobName = "Printing.."
        //
        //        printInfo.outputType = .photo
        //        printController.printInfo = printInfo
        //        printController.printingItems = [self.editImage]
        //
        //        printController.present(animated: true) { (_, isPrinted , error) in
        //
        //            if isPrinted{
        //                print("image is printed")
        //            }else{
        //                print("image is not printed")
        //            }
        //        }
        
        
        //
        //        //self.present(activityController, animated: true, completion: nil)
        //let shareVC = UIActivityViewController(activityItems: [data], applicationActivities: nil)
        //shareVC.accessibilityElement(at: i)
        
        //self.present(shareVC, animated: true,completion: nil)
    }
    
    
    func createPDFDataFromImage(image: UIImage) -> NSMutableData {
        let pdfData = NSMutableData()
        let imgView = UIImageView.init(image: image)
        let imageRect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        UIGraphicsBeginPDFContextToData(pdfData, imageRect, nil)
        UIGraphicsBeginPDFPage()
        let context = UIGraphicsGetCurrentContext()
        imgView.layer.render(in: context!)
        UIGraphicsEndPDFContext()

        //try saving in doc dir to confirm:
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last
        let path = dir?.appendingPathComponent("file.pdf")
        //print(path)

        do {
                try pdfData.write(to: path!, options: NSData.WritingOptions.atomic)
        } catch {
            print("error catched")
        }

        return pdfData
    }
    
    //image save to album
    
    @objc func imageSave(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {

        if let error = error {

            print(error.localizedDescription)

        } else {

            print("Success")
            showMessageToUser(title: "Alert", msg: "Documents saved")
        }
    }
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    
    // MARK: - Signature Pressed
    
    @IBAction func signaturePressed(_ sender: UIButton) {
        print(#function)
        UIImageWriteToSavedPhotosAlbum(self.editImage, self, #selector(imageSave(_:didFinishSavingWithError:contextInfo:)), nil)
        
    }
    
    
    
    //-------------------------------------------------------------------------------------------------------------------------------------------------
    
    
    
    // MARK: - Rotate Pressed
    
    @IBAction func rotatePressed(_ sender: UIButton) {
        print(#function)
        
                let printController = UIPrintInteractionController.shared
        
                let printInfo = UIPrintInfo(dictionary: nil)
        
                printInfo.jobName = "Printing.."
        
                printInfo.outputType = .photo
                printController.printInfo = printInfo
                printController.printingItems = [self.editImage]
        
                printController.present(animated: true) { (_, isPrinted , error) in
        
                    if isPrinted{
                        print("image is printed")
                    }else{
                        print("image is not printed")
                    }
                }
        
        //self.setImageRotation()
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
