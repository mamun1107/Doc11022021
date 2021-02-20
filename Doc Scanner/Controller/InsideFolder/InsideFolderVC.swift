//
//  InsideFolderVC.swift
//  Doc Scanner
//
//  Created by LollipopMacbook on 20/2/21.
//

import UIKit
import VisionKit
import RealmSwift

class InsideFolderVC: UIViewController {
    
    @IBOutlet weak var topBarStackView: UIStackView!
    @IBOutlet weak var galleryButton: UIButton!
    @IBOutlet weak var folderButton: UIButton!
    
    var primaryKeyName:String?
    var titleHeader:String?
    //var homeObject:HomeVC?
    //var whereitCommingFrom:String?
    
    
    var gridButttonSelected = Bool()
    var listButtonSelected = Bool()
    
    var docsTableView: UITableView = UITableView()
    var docsCollectionView: UICollectionView!
    
    var insideDocuments = [Documents]()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print("inside folder VC")
       // self.title = self.titleHeader ?? ""
        self.initVC()
        
        self.insideDocuments.removeAll()
        guard let primaryKey = self.primaryKeyName else {return}
        self.insideDocuments = self.readDocumentFromRealm(folderName: primaryKey, sortBy: "documentSize")
        //print(self.insideDocuments[0].editabledocumentName!)
        if self.listButtonSelected == true{
            self.setinsideDocumentTableView()
            self.docsTableView.tableFooterView = UIView()
            self.docsTableView.reloadData()
        }
        else if self.gridButttonSelected == true{
            self.setDocumentCollectionView()
            self.docsCollectionView.reloadData()
        }
        

       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("will appear")
    }
    
    
    //MARK:- scanner button clicked
    @IBAction func ScanButtonClicked(_ sender: UIButton) {
        print("scanner button clicked")
    }
    

}















extension InsideFolderVC{
    
    func initVC(){
       // self.gridButttonSelected = false
        //self.listButtonSelected = true
        self.setCustomNavigationBar(largeTitleColor: UIColor.black, backgoundColor: UIColor.white, tintColor: UIColor.black, title: "\(self.titleHeader ?? "")", preferredLargeTitle: true)
        
        self.setViewCustomColor(view: self.view, color: UIColor(hex: "EEEEEE"))
        self.setNavigationElements()
    }
    
    
    func setNavigationElements() {
        
        // MARK:- Selection  Bar select and delete Button
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Select", style: .plain, target: self, action: #selector(selection))
        
    }
    
    @objc func selection() {
        print(#function)
        
        self.navigationItem.rightBarButtonItem?.title = "Select"
        
    }
    
    
    
}

