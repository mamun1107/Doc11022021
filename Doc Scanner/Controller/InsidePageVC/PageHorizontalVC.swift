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
    
    var alldocs = [Documents]()
    var itemIndex:Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        horizontalView.tempIndex = itemIndex

        // Do any additional setup after loading the view.
    }
  

}

extension PageHorizontalVC : UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return alldocs.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PageCvCell
         //UIImage(data: self.alldocs[indexPath.row].documentData ?? Data())
        let item = alldocs[(indexPath as NSIndexPath).item]
        cell.imageView.image = UIImage(data: item.documentData ?? Data())
        //cell.label.text = item.label
        return cell
    }
}
