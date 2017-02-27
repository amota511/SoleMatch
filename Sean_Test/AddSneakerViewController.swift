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
        setupView()
        
    }
    
    func setupView(){
        
        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        blurView.frame.origin.x = 0
        blurView.frame.origin.y = 0
        blurView.frame.size.width = self.view.bounds.width
        blurView.frame.size.height = self.view.bounds.height
        
        
        let view = UIView(frame: CGRect(x: self.view.frame.width / 4, y: self.view.frame.height / 4, width: self.view.frame.width / 2, height: self.view.frame.height / 2))
        view.backgroundColor = UIColor
        blurView.addSubview(view)
        
        self.view.addSubview(blurView)
    }
}
