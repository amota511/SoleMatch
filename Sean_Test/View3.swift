//
//  View3.swift
//  Sean_Test
//
//  Created by amota511 on 1/21/17.
//  Copyright © 2017 Aaron Motayne. All rights reserved.
//

import UIKit

class View3: UIViewController {

    var scrollView: UIScrollView!
    
    lazy var leftButton: UIButton = {
        var button = UIButton()
        button.setTitle("Left", for: .normal)
        
        button.setTitleColor(UIColor.blue, for: .normal)
        button.addTarget(self, action: #selector(scrollLeft), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(leftButton)
        
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        leftButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 24).isActive = true
        leftButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive = true
        leftButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/12).isActive = true
        leftButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/15).isActive = true
        
    }

    override func viewDidAppear(_ animated: Bool) {
        self.scrollView = self.view.superview as! UIScrollView
    }
    
    func scrollLeft(){
        let v2Frame : CGRect = CGRect(x: Int(self.view.frame.width), y: 0, width: Int(scrollView.frame.width / 3), height: Int(scrollView.frame.height))
        self.scrollView.scrollRectToVisible(v2Frame, animated: true)
        print("The left button was excecuted")
    }


}
