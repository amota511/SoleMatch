//
//  View1.swift
//  Sean_Test
//
//  Created by amota511 on 1/21/17.
//  Copyright © 2017 Aaron Motayne. All rights reserved.
//

import UIKit

class View1: UIViewController {

    var scrollView: UIScrollView!
    
    lazy var rightButton: UIButton = {
        var button = UIButton()
        button.setTitle("Right", for: .normal)
        
        button.setTitleColor(UIColor.blue, for: .normal)
        button.addTarget(self, action: #selector(scrollRight), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(rightButton)
        
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        rightButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 24).isActive = true
        rightButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12).isActive = true
        rightButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/8).isActive = true
        rightButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/15).isActive = true
    }

    func scrollRight(){
        let v2Frame : CGRect = CGRect(x: Int((self.view.frame.width) * 1.67), y: 0, width: Int(scrollView.frame.width / 3), height: Int(scrollView.frame.height))
        self.scrollView.scrollRectToVisible(v2Frame, animated: true)
        print("The right button was excecuted")
    }

    override func viewDidAppear(_ animated: Bool) {
        self.scrollView = self.view.superview as! UIScrollView
    }
    
}
