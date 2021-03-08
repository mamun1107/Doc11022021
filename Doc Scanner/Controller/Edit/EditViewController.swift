//
//  ViewController.swift
//  Doc Scanner
//
//  Created by LollipopMacbook on 7/3/21.
//

import UIKit

class EditViewController: UIViewController {
    
    
    
    @IBOutlet weak var topStack: UIStackView!
    
    @IBOutlet weak var customVIew: UIView!
    
    @IBOutlet weak var drawnImageView: UIImageView!
    
    var editBtn = UIButton()
    var editImage = UIImage()
    var canvasView = UIView()
    var path = UIBezierPath()
    var startPoint = CGPoint()
    var touchPoint = CGPoint()
    
    fileprivate weak var savedImageView: UIImageView?
    //fileprivate weak var drawnImageView: UIImageView?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let drawnImageView = addImageView(image: editImage) as DrawnImageView
       // drawnImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 44.0).isActive = true
//        drawnImageView.centerXAnchor.constraint(equalTo: customVIew.centerXAnchor).isActive = true
//        drawnImageView.centerYAnchor.constraint(equalTo: customVIew.centerYAnchor).isActive = true
//        drawnImageView.topAnchor.constraint(equalTo: topStack.topAnchor, constant: 1.0).isActive = true
        //imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0.0).isActive = true
        //imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 10.0).isActive = true
//        drawnImageView.widthAnchor.constraint(equalToConstant: customVIew.frame.width).isActive = true
//        drawnImageView.heightAnchor.constraint(equalToConstant: customVIew.frame.height).isActive = true
        //drawnImageView.heightAnchor.constraint(equalToConstant: customVIew.frame.height).isActive = true
        self.drawnImageView = drawnImageView
        
//        let button = UIButton()
//        button.setTitle("Save Image", for: .normal)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setTitleColor(.blue, for: .normal)
//        view.addSubview(button)
//        button.topAnchor.constraint(equalTo: drawnImageView.bottomAnchor, constant: 60).isActive = true
//        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
//        button.addTarget(self, action: #selector(saveImageButtonTouchUpInside), for: .touchUpInside)
//
//        let savedImageView = addImageView()
//        savedImageView.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 60).isActive = true
//        savedImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        self.savedImageView = savedImageView
    }
    
    
    private func addImageView<T: UIImageView>(image: UIImage? = nil) -> T {
        let imageView = T(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        self.view.addSubview(customVIew)
        self.customVIew.addSubview(imageView)
       
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        
        imageView.centerXAnchor.constraint(equalTo: customVIew.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: customVIew.centerYAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: customVIew.topAnchor, constant: 2.0).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: customVIew.frame.width).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: customVIew.frame.height).isActive = true

       
        return imageView
    }
    
    @objc func saveImageButtonTouchUpInside(sender: UIButton) {
        savedImageView?.image = drawnImageView?.screenShot
    }
}

class DrawnImageView: UIImageView {
    private lazy var path = UIBezierPath()
    private lazy var previousTouchPoint = CGPoint.zero
    private lazy var shapeLayer = CAShapeLayer()

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setupView(){
        layer.addSublayer(shapeLayer)
        shapeLayer.lineWidth = 50
        shapeLayer.fillColor = nil
        shapeLayer.opacity = 0.1
        shapeLayer.strokeColor = UIColor.blue.cgColor
        isUserInteractionEnabled = true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if let location = touches.first?.location(in: self) { previousTouchPoint = location }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        if let location = touches.first?.location(in: self) {
            path.move(to: location)
            path.addLine(to: previousTouchPoint)
            previousTouchPoint = location
            shapeLayer.path = path.cgPath
        }
    }
}

//// https://stackoverflow.com/a/40953026/4488252
extension UIView {
    var screenShot: UIImage?  {
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale)
        if let context = UIGraphicsGetCurrentContext() {
            layer.render(in: context)
            let screenshot = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return screenshot
        }
        return nil
    }
}
