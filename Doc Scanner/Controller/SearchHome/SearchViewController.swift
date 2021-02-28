//
//  SearchViewController.swift
//  Doc Scanner
//  Created by LollipopMacbook on 6/2/21.





import UIKit

class SearchViewController: UIViewController {
    
    // variable
    var totalFolders = [Folders]()
    var totalDocuments = [Documents]()
 
    var searching = false
    var selected: String?
    var insideSearching:Bool = false

    
    @IBOutlet var searchBar: UISearchBar!
    
    @IBOutlet var tableView: UITableView!
    
    var filterSearchData = [AllSearchData]()
    var allserarchdata = [AllSearchData]()
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Search"
        Extention.designDisplayMood(controller:self)
        tableViewinit()
        self.searchBar.delegate = self
        //self.setCustomNavigationBar(largeTitleColor: UIColor.black, backgoundColor: UIColor.white, tintColor: UIColor.black, title: "Search", preferredLargeTitle: true)
        //self.navigationItem.backBarButtonItem?.isEnabled = false
        //self.navigationItem.hidesBackButton = true
        insertSearchData()
        setupSearchTableView()
        
        self.searchBar.showsCancelButton = true
        
        // Change TextField Colors
        let searchTextField = self.searchBar.searchTextField
        
        searchTextField.clearButtonMode = .whileEditing
        self.searchBar.keyboardAppearance = .dark
        self.tableView.separatorStyle = .none
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(true, animated: animated)
//    }

//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        navigationController?.setNavigationBarHidden(false, animated: animated)
//    }
    
    func insertSearchData(){
        
        let totaldata = self.totalFolders.count
        
        for i in 0..<totaldata{
            var customImage:UIImage = UIImage()
            
            if self.totalFolders[i].isPasswordProtected == true{
                customImage = UIImage(named: HomeAsset.folderLockImage)!
            }else{
                customImage = UIImage(named: HomeAsset.folderUnlockImage)!
            }
            let totaldocs = String(self.totalFolders[i].documents.count) + " Document(s)"
            
            self.allserarchdata.append(AllSearchData(name: self.totalFolders[i].editablefolderName ?? "", primaryKey: self.totalFolders[i].folderName ?? "" , image: customImage, totaldoc: totaldocs, ispasswordProtected: self.totalFolders[i].isPasswordProtected, password: self.totalFolders[i].password ?? "", originalImage: UIImage(named: HomeAsset.folderUnlockImage)!))
     
            
        }
        
        
        let totaldocdata = self.totalDocuments.count
        
        for i in 0..<totaldocdata{
            
            var customImage:UIImage = UIImage()
            
            if self.totalDocuments[i].isPasswordProtected == true{
                customImage = UIImage(named: HomeAsset.fileLockImage)!
            }else{
                customImage = UIImage(data: self.totalDocuments[i].documentData ?? Data())!
                
            }
            let onlydoc = "1 Document"
            //let isprotected:Bool = self.totalDocuments[i].isPasswordProtected
            
            self.allserarchdata.append(AllSearchData(name: self.totalDocuments[i].editabledocumentName ?? "",primaryKey: self.totalDocuments[i].documentName ?? "",  image: customImage, totaldoc: onlydoc, ispasswordProtected: self.totalDocuments[i].isPasswordProtected, password: self.totalDocuments[i].password ?? "", originalImage: UIImage(data: self.totalDocuments[i].documentData ?? Data())!))

            
        }
    }
    
    
    func setupSearchTableView(){
        self.tableView.register(UINib(nibName: "FolderTVCell", bundle: nil), forCellReuseIdentifier: "folderCell")
    }
    
}


extension SearchViewController: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText == ""{
            searching = false
            tableView.reloadData()
        }else{
            filterSearchData = allserarchdata.filter { (item) in
                (item.name?.lowercased().contains(searchText.lowercased()))!}
            searching = true
            tableView.reloadData()
        }
        
        
    }
    
    
    //every thing s is ok
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tableView.reloadData()
        self.navigationController?.popToRootViewController(animated: true)
    
        
    }
}


