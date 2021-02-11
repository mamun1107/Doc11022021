//
//  AlertView.swift
//  Doc Scanner
//
//  Created by LollipopMacbook on 30/1/21.
//

import UIKit

class AlertView: UIView {
   
    static let instance = AlertView()
    
    @IBOutlet weak var alertView: UIView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
      //  Bundle.main.loadNibNamed("AlertView", owner: self, options: nil)
         //commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {

        alertView.layer.cornerRadius = 10
        
        //parentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
       // parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    enum AlertType {
        case success
        case failure
    }
    
    func showAlert(title: String, message: String, alertType: AlertType) {
     
        UIApplication.shared.keyWindow?.addSubview(alertView)
    }
    
    
    
    @IBAction func onClickDone(_ sender: Any) {
        //parentView.removeFromSuperview()
    }
    

}

