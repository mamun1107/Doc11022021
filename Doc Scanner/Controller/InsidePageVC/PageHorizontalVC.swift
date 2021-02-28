//
//  PageHorizontalVC.swift
//  Doc Scanner
//
//  Created by LollipopMacbook on 28/2/21.
//

import UIKit
//import PagedHorizontalView

class PageHorizontalVC: UIViewController {
    
    @IBOutlet weak var horizontalView: PagedHorizontalView!
    var imageScrollView: ImageScrollView!
    
    var alldocs = [Documents]()
    var itemIndex:Int = 0
    var rotationCounter: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        horizontalView.tempIndex = itemIndex

        // Do any additional setup after loading the view.
    }
  
    @IBAction func editbuttonclicked(_ sender: UIButton) {
        print(horizontalView.tempIndex)
    }
    
    
    @IBAction func rotateButtonClicked(_ sender: UIButton) {
        
        let insideVcImage:UIImage = UIImage(data: self.alldocs[horizontalView.tempIndex].documentData ?? Data()) ?? UIImage()
//        let editObject = EditVC()
//        editObject.editImage = insideVcImage
//        editObject.imageScrollView = imageScrollView1
        self.setImageRotation(temp:insideVcImage)
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
extension PageHorizontalVC{
    
    func setImageRotation(temp:UIImage) {
        
        self.rotationCounter += 1
        
        if self.rotationCounter == 1 {
           // print("prinnt1")
            //self.editImageView.image = UIImage(cgImage: self.editImage.cgImage!, scale: 1, orientation: .right)
           // self.imageScrollView.set(image:UIImage(cgImage: temp as! CGImage, scale: 1, orientation: .right))
        }
        
        else if self.rotationCounter == 2 {
            //print("prinnt2")
           
            //self.imageScrollView.set(image:UIImage(cgImage: temp as! CGImage, scale: 1, orientation: .down))
            
            //self.editImageView.image = UIImage(cgImage: self.editImage.cgImage!, scale: 1, orientation: .down)
        }
        
        else if self.rotationCounter == 3 {
            //print("prinnt3")
           // self.imageScrollView.set(image:UIImage(cgImage: temp as! CGImage, scale: 1, orientation: .left))
            
            //self.editImageView.image = UIImage(cgImage: self.editImage.cgImage!, scale: 1, orientation: .left)
        }
        
        else {
           // print("prinnt4")
            
            //self.editImageView.image = UIImage(cgImage: self.editImage.cgImage!, scale: 1, orientation: .up)
           // self.imageScrollView.set(image:UIImage(cgImage: self.editImage.cgImage!, scale: 1, orientation: .up))
            
            self.rotationCounter = 0
        }
    }

}
