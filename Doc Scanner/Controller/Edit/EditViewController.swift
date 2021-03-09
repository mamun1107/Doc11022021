//
//  ViewController.swift
//  Doc Scanner
//
//  Created by LollipopMacbook on 7/3/21.
//

import UIKit
import PencilKit

@available(iOS 14.0, *)
class EditViewController: UIViewController {
    
    var editImage:UIImage = UIImage()
    
    var colorbuttonSelected:Bool = false
    
    @IBOutlet weak var topStack: UIStackView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var customVIew: UIView!
    
    @IBOutlet weak var bottomSpceForFilterView: NSLayoutConstraint!
    
    lazy var canvasView:Canvas = Canvas(view: customVIew, imageView: imageView)
    
    //var draw: Draw?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        canvasView.drawingPolicy = .default
        setUpCanvas()
    }
    
    func setUp() {
        setUpView()
        setupImage()
    }
    
    func setUpView() {
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.addSubview(canvasView)
        
    }
    
    func setupImage() {
        
        imageView.image = editImage
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

            guard
                let window = view.window,
                let toolPicker = PKToolPicker.shared(for: window) else { return }

            toolPicker.setVisible(true, forFirstResponder: canvasView)
            toolPicker.addObserver(canvasView)
            canvasView.becomeFirstResponder()
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        //setUpCanvas()
//    }
    
    func setUpCanvas() {
        guard let window = view.window, let toolPiker = PKToolPicker.shared(for: window) else {
            return
        }
       // canvasView.drawingPolicy = .default
        toolPiker.setVisible(true, forFirstResponder: canvasView)
        toolPiker.addObserver(canvasView)
        canvasView.becomeFirstResponder()
    }
    
    @IBAction func save(_ sender: Any) {
        let annotationImage =  canvasView.drawing.image(from: imageView.bounds, scale: 1.0)
        guard let image = imageView.image else { return }
        let joinedImage = image.mergeWith(topImage: annotationImage)
        shareImage(image: joinedImage)
    }
    
    private func shareImage(image: UIImage) {
        let item: [Any] = [image]
        let ac = UIActivityViewController(activityItems: item, applicationActivities: nil)
        self.present(ac, animated: true)
    }
    
    @IBAction func colorbuttonClicked(_ sender: Any) {
        guard let window = view.window, let toolPiker = PKToolPicker.shared(for: window) else {
            return
        }
        toolPiker.setVisible(true, forFirstResponder: canvasView)
        toolPiker.addObserver(canvasView)
        canvasView.becomeFirstResponder()
    }
    
    
    @IBAction func eraseButtonClicked(_ sender: Any) {
        canvasView.drawing = PKDrawing()
    }
    
    
    @IBAction func exportButtonClicked(_ sender: Any) {
//                var value = bottomSpceForFilterView.constant
//                value = 0
//                UIView.animate(withDuration: 0.7) {
//                    self.bottomSpceForFilterView.constant = value
//                    self.view.layoutIfNeeded()
//                }
    }
    
    
    
    
}

@available(iOS 14.0, *)
extension EditViewController{
    
    
    @IBAction func gotoFilterView(_ sender: Any) {
        

        
    }
    
    @IBAction func downTheFilterView(_ sender: Any) {
//        var value = bottomSpceForFilterView.constant
//        value = -1000
//        UIView.animate(withDuration: 0.7) {
//            self.bottomSpceForFilterView.constant = value
//            self.view.layoutIfNeeded()
//        }
    }
}
