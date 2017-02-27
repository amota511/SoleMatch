//
//  AddSneakerViewController.swift
//  SoleMatch
//
//  Created by amota511 on 2/26/17.
//  Copyright © 2017 Aaron Motayne. All rights reserved.
//

import UIKit

class AddSneakerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        createBlurView()
        
    }
    
    func createBlurView() {
        
        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        blurView.frame.origin.x = 0
        blurView.frame.origin.y = 0
        blurView.frame.size.width = self.view.bounds.width
        blurView.frame.size.height = self.view.bounds.height
        
        let dismissTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(removeView))
        blurView.addGestureRecognizer(dismissTapGestureRecognizer)
        
        self.view.addSubview(blurView)
        
        setupContainerView(blurView: blurView)
    }
    
    func setupContainerView(blurView: UIVisualEffectView){
        
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width / 1.25, height: self.view.frame.width / 1.25))
        containerView.center = CGPoint(x: self.view.center.x, y: self.view.center.y + self.view.center.y / 6)
        containerView.backgroundColor = UIColor(red: 245.0/255.0, green: 245.0/255.0, blue: 245.0/255.0, alpha: 1.0)
        containerView.alpha = 0
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = 10
        
        blurView.addSubview(containerView)
        
        UIView.animate(withDuration: 1.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [.curveEaseInOut] , animations: {

            containerView.frame.size = CGSize(width: self.view.frame.width * 0.90, height: self.view.frame.width * 0.90)
            containerView.center = self.view.center
        }) { (completion) in
            
        }
        
        UIView.animate(withDuration: 0.5, animations: {
            
            containerView.alpha = 1.0
           
        }) { (completion) in
            
        }
    }
    
    
    
    func removeView() {
        print("removeView function sucessfully called.")
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
    }
    
}
