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
    
    @IBOutlet weak var bottomView: UIView!
    
    var primaryKeyName:String?
    var titleHeader:String?
    
    
    var gridButttonSelected = Bool()
    var listButtonSelected = Bool()
    
    var docsTableView: UITableView = UITableView()
    var docsCollectionView: UICollectionView!
    
    var insideDocuments = [Documents]()
 
    var listSelect:Bool = Bool()
    var gridSelect:Bool = Bool()
    
    
    //View DidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initVC()
        self.insideDocuments.removeAll()
        guard let primaryKey = self.primaryKeyName else {return}
        self.insideDocuments = self.readDocumentFromRealm(folderName: primaryKey, sortBy: "documentSize")
        
        
        if self.listButtonSelected == true{
            self.listSelect = true
            self.gridSelect = false
            self.setinsideDocumentTableView()
            self.docsTableView.tableFooterView = UIView()
            self.docsTableView.reloadData()
            
        }
        else if self.gridButttonSelected == true{
            self.listSelect = false
            self.gridSelect = true
            self.setDocumentCollectionView()
            self.docsCollectionView.reloadData()
            
            
        }

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
       // print("will appear")
        self.bottomView.setNeedsLayout()
        self.bottomView.layoutIfNeeded()
        self.navigationController?.hidesBottomBarWhenPushed = true
        self.bottomView.setNeedsUpdateConstraints()
        
        self.navigationController?.navigationBar.isHidden = false
        
        self.setRefreshTVandCV(SortBy: "documentSize")
        if listSelect == true{
            DispatchQueue.main.async {
                self.docsTableView.reloadData()
            }
        }else{
            DispatchQueue.main.async {
                self.docsCollectionView.reloadData()
            }
        }

    }
    
    
    //MARK:- scanner button clicked
    @IBAction func ScanButtonClicked(_ sender: UIButton) {
        print("scanner button clicked")
        let vnDocVC = VNDocumentCameraViewController()
        vnDocVC.delegate = self
        present(vnDocVC, animated: false)
        
        
    }
    
    
    @IBAction func listButtonClicked(_ sender: UIButton) {
        
    
        if self.listSelect == false{
            setUPtable()
        }else{
            print("Nothings..")
        }
        
        
        
    }
    
    
    @IBAction func gridListButtonClicked(_ sender: UIButton) {
        
        if self.gridSelect == false{
           setUPgrid()
        }else{
            print("Nothings..")
        }
        
   
        
    }
    
    
    
    @IBAction func filterButtonClicked(_ sender: UIButton) {
        print("filter button clicked")
        setActionSheetforInsideFolder()
    }
    
    
    
    
}


// MARK:-


extension InsideFolderVC{
    
    func initVC(){
        self.setCustomNavigationBar(largeTitleColor: UIColor.black, backgoundColor: UIColor.white, tintColor: UIColor.black, title: "\(self.titleHeader ?? "")", preferredLargeTitle: true)
        
        self.setViewCustomColor(view: self.view, color: UIColor(hex: "EEEEEE"))
        self.setNavigationElements()

    }
    
    // MARK: - Set Refresh TVandCV
    
    func setRefreshTVandCV(SortBy: String) {
       
        guard let primaryKey = self.primaryKeyName else {return}
        //self.insideDocuments = self.readDocumentFromRealm(folderName: primaryKey, sortBy: "documentSize")
        self.insideDocuments.removeAll()
        self.insideDocuments = self.readDocumentFromRealm(folderName: primaryKey, sortBy: "documentSize")
        if listSelect == true{
            DispatchQueue.main.async {
                self.docsTableView.reloadData()
            }
        }else{
            DispatchQueue.main.async {
                self.docsCollectionView.reloadData()
            }
        }
       
    }
    
    func setUPtable(){
        self.listSelect = true
        self.gridSelect = false
        self.docsCollectionView.removeFromSuperview()
        self.setinsideDocumentTableView()
        self.docsTableView.tableFooterView = UIView()
        self.docsTableView.reloadData()
    }
//
    func setUPgrid(){
        self.gridSelect = true
        self.listSelect = false
        self.docsTableView.removeFromSuperview()
        self.setDocumentCollectionView()
        self.docsCollectionView.reloadData()
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



