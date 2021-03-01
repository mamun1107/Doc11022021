//
//  InsideFolderVC.swift
//  Doc Scanner
//
//  Created by LollipopMacbook on 20/2/21.
//


struct Model {
    let image: UIImage
    let title: String
    
    init(image:UIImage, title:String){
        self.image = image
        self.title = title
    }

    var inputSource: InputSource {
        return ImageSource(image: image)
    }
}


import UIKit
import VisionKit
import RealmSwift




class InsideFolderVC: UIViewController {
    
    @IBOutlet weak var topBarStackView: UIStackView!
    
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var listButton: UIButton!
    
    @IBOutlet weak var gridButton: UIButton!
    
    var primaryKeyName:String?
    var titleHeader:String?
    
    
    var gridButttonSelected = Bool()
    var listButtonSelected = Bool()
    
    var docsTableView: UITableView = UITableView()
    var docsCollectionView: UICollectionView!
    
    var insideFilterDocuments = [Documents]()
    var insideDocuments = [Documents]()
    var model = [Model]()
 
    var listSelect:Bool = Bool()
    var gridSelect:Bool = Bool()
    var slideshowTransitioningDelegate: ZoomAnimatedTransitioningDelegate? = nil
    
    //View DidLoad
    
    
    @IBOutlet weak var bottomViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var bottomViewImageHeight: NSLayoutConstraint!
    

    
    @IBOutlet weak var bottomImage: UIImageView!
    
    @IBOutlet weak var bottomButtonHeightwithSafearea: NSLayoutConstraint!
    
    let searchBar = UISearchBar()
    var searching:Bool = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = titleHeader
        let modelName = UIDevice.modelName
        //print(modelName)
        customDesignUsingDeviceModel(modelName:modelName)
        self.setViewCustomColor(view: self.view, color: UIColor(hex: "EEEEEE"))
        self.searchBar.delegate = self
        self.initVC()
        self.insideDocuments.removeAll()
        guard let primaryKey = self.primaryKeyName else {return}
        self.insideDocuments = self.readDocumentFromRealmForName(folderName: primaryKey, sortBy: "editabledocumentName")
        
        if self.listButtonSelected == true{
            initListButtonSelected()
            
        }
        else if self.gridButttonSelected == true{
            initGridButtonSelected()
            
        }
        
        
        
    }
    
    
    func customDesignUsingDeviceModel(modelName:String){
       // iPhone 7
        if modelName == "iPhone 7"{
            bottomButtonHeightwithSafearea.constant = 30
            bottomViewHeight.constant = 50
            bottomViewImageHeight.constant = 40
            bottomImage.contentMode = .scaleToFill
  
            
            
        }else{
            bottomViewHeight.constant = 80
            bottomViewImageHeight.constant = 72
            bottomButtonHeightwithSafearea.constant = 15
        
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        print("will appear")
        //self.view.endEditing(true)
        self.setViewCustomColor(view: self.view, color: UIColor(hex: "EEEEEE"))
        self.bottomView.setNeedsLayout()
        self.bottomView.layoutIfNeeded()
        self.navigationController?.hidesBottomBarWhenPushed = true
        self.bottomView.setNeedsUpdateConstraints()
        
        self.navigationController?.navigationBar.isHidden = false
        guard let primaryKey = self.primaryKeyName else {return}
        self.insideDocuments = self.readDocumentFromRealmForName(folderName: primaryKey, sortBy: "editabledocumentName")
        refreshTVandCVDynamicly()
      

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
            gridButtonDeSelect()
            listButtonSelect()
            setUPtable()
        }else{
            print("Nothings..")
        }
        
        
        
    }
    
    
    @IBAction func gridListButtonClicked(_ sender: UIButton) {
        
        if self.gridSelect == false{
            listButtonDeSelect()
            gridButtonSelect()
            setUPgrid()
        }else{
            print("Nothings..")
        }
        
        
        
    }
    
    
    
    @IBAction func filterButtonClicked(_ sender: UIButton) {
        print("filter button clicked")
        setActionSheetforInsideFolder()
    }
    
    
    @IBAction func searchButtonClicked(_ sender: UIButton) {
        self.topBarStackView.isHidden = true
        self.searchBar.isHidden = false
        designUIsearchBar()
    }
    
    
    
    
    
}
//MARK:-Another Section
extension InsideFolderVC:UISearchBarDelegate{
    
    func designUIsearchBar(){
        searchBar.frame =  CGRect(x: 0, y: self.topbarHeight + 4.0, width: UIScreen.main.bounds.width, height: 50)
        searchBar.searchBarStyle = .minimal
        self.searchBar.showsCancelButton = true
        
        // Change TextField Colors
        let searchTextField = self.searchBar.searchTextField
        
        searchTextField.clearButtonMode = .whileEditing
        self.searchBar.keyboardAppearance = .dark
        self.view.addSubview(searchBar)
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText == ""{
            searching = false
            refreshTVandCVDynamicly()
        }else{
            insideFilterDocuments = insideDocuments.filter { (item) in(item.editabledocumentName?.lowercased() .contains(searchText.lowercased()))!}
            searching = true
            refreshTVandCVDynamicly()
        }
        
        
    }
    
    
    //every thing s is ok
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        self.searchBar.isHidden = true
        self.topBarStackView.isHidden = false
        searching = false
        searchBar.text = ""
        refreshTVandCVDynamicly()
        self.view.endEditing(true)
    }
 
    
}

extension UIViewController {
    
    var topbarHeight: CGFloat {
        if #available(iOS 13.0, *) {
            return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
                (self.navigationController?.navigationBar.frame.height ?? 0.0)
        } else {
            let topBarHeight = UIApplication.shared.statusBarFrame.size.height +
                (self.navigationController?.navigationBar.frame.height ?? 0.0)
            return topBarHeight
        }
    }
    
    // Put this piece of code anywhere you like
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}





















// MARK:-


extension InsideFolderVC{
    
    func initVC(){
       // self.setCustomNavigationBar(largeTitleColor: UIColor.black, backgoundColor: UIColor.white, tintColor: UIColor.black, title: "\(self.titleHeader ?? "")", preferredLargeTitle: true)
        self.setViewCustomColor(view: self.view, color: UIColor(hex: "EEEEEE"))
        self.setNavigationElements()

    }
    
    
    func initListButtonSelected(){
        readDataforModelDetails()
        gridButtonDeSelect()
        listButtonSelect()
        self.listSelect = true
        self.gridSelect = false
        self.setinsideDocumentTableView()
        self.docsTableView.tableFooterView = UIView()
        self.docsTableView.reloadData()
    }
    
    func initGridButtonSelected(){
        readDataforModelDetails()
        listButtonDeSelect()
        gridButtonSelect()
        self.listSelect = false
        self.gridSelect = true
        self.setDocumentCollectionView()
        self.docsCollectionView.reloadData()
        
    }
    
    // MARK: - Set Refresh TVandCV
    
    func setRefreshTVandCV(SortBy: String) {
       
        guard let primaryKey = self.primaryKeyName else {return}
        //self.insideDocuments = self.readDocumentFromRealm(folderName: primaryKey, sortBy: "documentSize")
        self.insideDocuments.removeAll()
        self.insideDocuments = self.readDocumentFromRealmForName(folderName: primaryKey, sortBy: "editabledocumentName")
        refreshTVandCVDynamicly()
        
       
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
       self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(selection))
        
    }
    
    @objc func selection() {
        print(#function)
        
        self.navigationItem.rightBarButtonItem?.title = "Select"
        
    }
    
    
    
}

extension InsideFolderVC{
    
    
    func readDataforModelDetails(){
        self.model.removeAll()
        for i in 0..<insideDocuments.count{
            model.append(Model(image: UIImage(data: insideDocuments[i].documentData ?? Data())!, title: insideDocuments[i].editabledocumentName ?? ""))
        }
    }
    
    func listButtonSelect(){
        let folderOriginalImage = UIImage(named: "list_select_icon_final")
        let folderTintedImage = folderOriginalImage?.withRenderingMode(.alwaysTemplate)
        listButton.setImage(folderTintedImage, for: .normal)
        listButton.tintColor = .systemBlue
    }
    func listButtonDeSelect(){
        let folderOriginalImage = UIImage(named: "list_deselect_icon_final")
        let folderTintedImage = folderOriginalImage?.withRenderingMode(.alwaysTemplate)
        listButton.setImage(folderTintedImage, for: .normal)
        listButton.tintColor = .black
    }
    
    func gridButtonSelect(){
        
        let galaryOriginalImage = UIImage(named: "grid_select_icon_final")
        let galaryTintedImage = galaryOriginalImage?.withRenderingMode(.alwaysTemplate)
        gridButton.setImage(galaryTintedImage, for: .normal)
        gridButton.tintColor = .systemBlue
    }
    
    func gridButtonDeSelect(){
        let galaryOriginalImage = UIImage(named: "grid_deselect_icon_final")
        let galaryTintedImage = galaryOriginalImage?.withRenderingMode(.alwaysTemplate)
        gridButton.setImage(galaryTintedImage, for: .normal)
        gridButton.tintColor = .black
    }
    
    func refreshTVandCVDynamicly(){
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
    
    
}



