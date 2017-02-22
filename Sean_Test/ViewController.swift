//
//  ViewController.swift
//  Sean_Test
//
//  Created by amota511 on 1/13/17.
//  Copyright © 2017 Aaron Motayne. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    
    @IBOutlet var scrollView: UIScrollView!
    
    lazy var leftButton: UIButton = {
        var button = UIButton()
        button.setImage(#imageLiteral(resourceName: "Shoe Box"), for: .normal)
        button.addTarget(self, action: #selector(scrollLeft), for: .touchUpInside)
        return button
    }()
    
    lazy var centerButton: UIButton = {
        var button = UIButton()
        button.setTitle("Sole Match", for: .normal)
        button.titleLabel?.font = UIFont(name: "Pacifico-Regular", size: 24)
        button.addTarget(self, action: #selector(scrollCenter), for: .touchUpInside)
        button.titleLabel?.textAlignment = .center
        button.translatesAutoresizingMaskIntoConstraints = false
        //button.setTitleColor( UIColor(red: 225 / 255.0, green: 40/255.0, blue: 30/255.0, alpha: 1.0), for: .normal)
        return button
    }()
    
    lazy var rightButton: UIButton = {
        var button = UIButton()
        button.setImage(#imageLiteral(resourceName: "Location Love"), for: .normal)
        button.addTarget(self, action: #selector(scrollRight), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let v1 : View1 = View1(nibName: "View1", bundle: nil)
        self.addChildViewController(v1)
        self.scrollView.addSubview(v1.view)
        v1.didMove(toParentViewController: self)
        
        var v1Frame : CGRect = v1.view.frame
        v1Frame.size.height = scrollView.frame.height
        v1.view.frame = v1Frame
        
        let v2 : View2 = View2(nibName: "View2", bundle: nil)
        self.addChildViewController(v2)
        self.scrollView.addSubview(v2.view)
        v2.didMove(toParentViewController: self)
        
        var v2Frame : CGRect = v2.view.frame
        v2Frame.size.height = scrollView.frame.height
        v2Frame.origin.x = self.view.frame.width
        v2.view.frame = v2Frame

        let v3 : View3 = View3(nibName: "View3", bundle: nil)
        self.addChildViewController(v3)
        self.scrollView.addSubview(v3.view)
        v3.didMove(toParentViewController: self)
        
        var v3Frame : CGRect = v3.view.frame
        v3Frame.origin.x = 2 * self.view.frame.width
        v3Frame.size.height = scrollView.frame.height
        v3.view.frame = v3Frame
        
        self.scrollView.contentSize = CGSize(width: self.view.frame.width * 3, height: self.view.frame.height)
        
        self.scrollView.isScrollEnabled = false
        
        self.scrollView.scrollRectToVisible(v2Frame , animated: false)
        
        let headerView = UIView()
        headerView.backgroundColor = UIColor(red: 55/255.0, green: 61/255.0, blue: 60/255.0, alpha: 1.0)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(headerView)
        
        headerView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        headerView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        headerView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        headerView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/11).isActive = true

        //centerButton.titleLabel?.textColor = UIColor(red: 225 / 255.0, green: 40/255.0, blue: 30/255.0, alpha: 1.0) 

        headerView.addSubview(rightButton)
        headerView.addSubview(centerButton)
        headerView.addSubview(leftButton)
        
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        leftButton.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 24).isActive = true
        leftButton.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 12).isActive = true
        leftButton.widthAnchor.constraint(equalTo: headerView.widthAnchor, multiplier: 1/8).isActive = true
        leftButton.heightAnchor.constraint(equalTo: headerView.heightAnchor, multiplier: 1/2).isActive = true
        
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        rightButton.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 24).isActive = true
        rightButton.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: -12).isActive = true
        rightButton.widthAnchor.constraint(equalTo: headerView.widthAnchor, multiplier: 1/8).isActive = true
        rightButton.heightAnchor.constraint(equalTo: headerView.heightAnchor, multiplier: 1/2).isActive = true
        
        centerButton.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 24).isActive = true
        centerButton.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        centerButton.widthAnchor.constraint(equalTo: headerView.widthAnchor, multiplier: 1/2.5).isActive = true
        centerButton.heightAnchor.constraint(equalTo: headerView.heightAnchor, multiplier: 1/2).isActive = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getScrollView() -> UIScrollView {
        return scrollView
    }
    
    func scrollLeft(){
        let v1Frame : CGRect = CGRect(x: 0, y: 0, width: Int(scrollView.frame.width), height: Int(scrollView.frame.height))
        self.scrollView.scrollRectToVisible(v1Frame, animated: true)
        print("The left button was excecuted on main")
    }
    
    func scrollCenter(){
        let v2Frame : CGRect = CGRect(x: Int(scrollView.frame.width), y: 0, width: Int(scrollView.frame.width), height: Int(scrollView.frame.height))
        self.scrollView.scrollRectToVisible(v2Frame, animated: true)
        print("The center button was excecuted on main")
    }
    
    func scrollRight(){
        let v3Frame : CGRect = CGRect(x: Int(scrollView.frame.width) * 2, y: 0, width: Int(scrollView.frame.width), height: Int(scrollView.frame.height))
        self.scrollView.scrollRectToVisible(v3Frame, animated: true)
        print("The right button was excecuted on main")
    }
  
}
