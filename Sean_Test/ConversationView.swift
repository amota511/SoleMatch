//
//  ConversationView.swift
//  Sean_Test
//
//  Created by amota511 on 2/2/17.
//  Copyright © 2017 Aaron Motayne. All rights reserved.
//

import UIKit

class ConversationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        let headerView: UIView = {
            let headerView = UIView()
            headerView.backgroundColor = UIColor(red: 190/255.0, green: 100/255.0, blue: 100/255.0, alpha: 1.0)
            headerView.translatesAutoresizingMaskIntoConstraints = false
            return headerView
        }()
        
        self.view.addSubview(headerView)
        
        headerView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        headerView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        headerView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        headerView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/11).isActive = true
        
        let backButton: UIButton = {
            
            let button = UIButton()
            button.setTitle("< Back", for: .normal)
            button.setTitleColor(UIColor.blue, for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(dissmissConversationsView(sender:)), for: .touchUpInside)
            return button
        }()
        
        headerView.addSubview(backButton)
        
        backButton.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 12).isActive = true
        backButton.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 6).isActive = true
        backButton.widthAnchor.constraint(equalTo: headerView.widthAnchor, multiplier: 1/6).isActive = true
        backButton.heightAnchor.constraint(equalTo: headerView.heightAnchor, multiplier: 1/1.2).isActive = true
        
        
        
        
    }

    func dissmissConversationsView(sender: UIButton) {
        let conversationsView = sender.superview!.superview!
        
        UIView.animate(withDuration: 0.5, animations: {
            
            conversationsView.frame.origin.x = conversationsView.frame.width
            
        },  completion: {
            completed in
            
            conversationsView.removeFromSuperview()
        })
        
    }
    
}
