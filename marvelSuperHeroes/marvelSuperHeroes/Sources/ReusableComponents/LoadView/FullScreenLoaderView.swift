//
//  FullScreenLoaderView.swift
//  marvelSuperHeroes
//
//  Created by Rodrigo Gonçalves de Queiroz on 21/11/22.
//

import UIKit

class FullScreenLoaderView: UIViewController {
    
    static let viewCtrlLoader = FullScreenLoaderView(nibName: "FullScreenLoaderView", bundle: nil)
    @IBOutlet weak var imgLoader: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgLoader.rotateImage()
        setBackgroundOverlay(view: self.view)
    }
    
    static func show() {
        guard let rootViewCtrl = UIViewController.topViewController() else {
            return
        }
        
        viewCtrlLoader.view.layoutIfNeeded()
        viewCtrlLoader.modalPresentationStyle = .overFullScreen
        viewCtrlLoader.willMove(toParent: rootViewCtrl)
        
        rootViewCtrl.addChild(viewCtrlLoader)
        rootViewCtrl.view.addSubview(viewCtrlLoader.view)
        
        viewCtrlLoader.view.frame = rootViewCtrl.view.frame
        viewCtrlLoader.didMove(toParent: rootViewCtrl)
    }
    
    static func hide() {
        viewCtrlLoader.view.removeFromSuperview()
        viewCtrlLoader.willMove(toParent: nil)
        viewCtrlLoader.removeFromParent()
    }
    
    
}

extension UIViewController {
    
    //MARK: Function`s
    class func topViewController(viewCtrl: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        if let navCtrl = viewCtrl as? UINavigationController {
            return topViewController(viewCtrl: navCtrl.visibleViewController)
        }
        
        if let tabCtrl = viewCtrl as? UITabBarController, let selected = tabCtrl.selectedViewController {
            return topViewController(viewCtrl: selected)
        }
        
        if let presentedViewCtrl = viewCtrl?.presentedViewController {
            return topViewController(viewCtrl: presentedViewCtrl)
        }
        
        return viewCtrl
    }
    
    func setBackgroundOverlay(view: UIView) {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    }
    
}

extension UIView {
    
    func rotateImage(duration: CFTimeInterval = 1) {
        
        let rotation = CABasicAnimation(keyPath: "transform.rotation")
        rotation.fromValue = 0.0
        rotation.toValue = CGFloat(Double.pi * 2)
        rotation.isRemovedOnCompletion = false
        rotation.duration = duration
        rotation.repeatCount = Float.infinity
        
        self.layer.add(rotation, forKey: nil)
    }
}
