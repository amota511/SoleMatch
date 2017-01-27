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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let leftButton: UIButton = {
            let button = UIButton()
            button.setTitle("Left", for: .normal)
            button.setTitleColor(UIColor.blue, for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(scrollLeft), for: .touchUpInside)
            return button
        }()
        
        self.view.addSubview(leftButton)
        
        leftButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 24).isActive = true
        leftButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive = true
        leftButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/12).isActive = true
        leftButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/15).isActive = true
        
        
        let connectionsLabel: UILabel = {
            let label = UILabel()
            label.text = "Connections"
            label.textAlignment = .left
            label.backgroundColor = UIColor.white
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        self.view.addSubview(connectionsLabel)
        
        connectionsLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 72).isActive = true
        connectionsLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        connectionsLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        connectionsLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/22).isActive = true
        
        let connectionsCollectionView = createConnectionsCV()
        
        self.view.addSubview(connectionsCollectionView)
        
        connectionsCollectionView.topAnchor.constraint(equalTo: connectionsLabel.bottomAnchor).isActive = true
        connectionsCollectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        connectionsCollectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        connectionsCollectionView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/8).isActive = true
        
        
        let conversationsLabel: UILabel = {
            let label = UILabel()
            label.text = "Conversations"
            label.textAlignment = .left
            label.backgroundColor = UIColor.white
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        self.view.addSubview(conversationsLabel)
        
        conversationsLabel.topAnchor.constraint(equalTo: connectionsCollectionView.bottomAnchor, constant: 15).isActive = true
        conversationsLabel.centerXAnchor.constraint(equalTo: connectionsCollectionView.centerXAnchor).isActive = true
        conversationsLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        conversationsLabel.heightAnchor.constraint(equalTo: connectionsLabel.heightAnchor).isActive = true
        
        
        let conversationsTableView = createConversationsTV()
        
        self.view.addSubview(conversationsTableView)
        
        conversationsTableView.topAnchor.constraint(equalTo: conversationsLabel.bottomAnchor).isActive = true
        conversationsTableView.centerXAnchor.constraint(equalTo: conversationsLabel.centerXAnchor).isActive = true
        conversationsTableView.widthAnchor.constraint(equalTo: conversationsLabel.widthAnchor).isActive = true
        conversationsTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }

    override func viewDidAppear(_ animated: Bool) {
        self.scrollView = self.view.superview as! UIScrollView
    }
    
    func scrollLeft(){
        let v2Frame : CGRect = CGRect(x: Int(self.view.frame.width), y: 0, width: Int(scrollView.frame.width / 3), height: Int(scrollView.frame.height))
        self.scrollView.scrollRectToVisible(v2Frame, animated: true)
        print("The left button was excecuted")
    }
    
    func createConnectionsCV() -> UICollectionView {
        
        let connectionsLayout = UICollectionViewFlowLayout()
        connectionsLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        connectionsLayout.scrollDirection = .horizontal
        
        
        
        let connectionsCollectionView = UICollectionView(frame: CGRect(x: 0, y: 100, width: self.view.frame.width, height: self.view.frame.height * (1/8)), collectionViewLayout: connectionsLayout)
        connectionsLayout.itemSize = CGSize(width: connectionsLayout.collectionView!.frame.width * (1/6), height: connectionsLayout.collectionView!.frame.height * (5/6))
        connectionsCollectionView.dataSource = self
        connectionsCollectionView.delegate = self
        connectionsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        connectionsCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "ConnectionsCell")
        connectionsCollectionView.isScrollEnabled = true
        connectionsCollectionView.backgroundColor = UIColor.white
        connectionsCollectionView.showsHorizontalScrollIndicator = false
        connectionsCollectionView.allowsSelection = true
        connectionsCollectionView.alwaysBounceHorizontal = true
        connectionsCollectionView.bounces = true
        
        return connectionsCollectionView
    }
    
    func createConversationsTV() -> UITableView {
        
        let frame = CGRect(x: 0, y: 0, width: self.view.frame.width , height: self.view.frame.height / 2)
        
        let conversationsTableView = UITableView(frame: frame, style: .plain)
        conversationsTableView.translatesAutoresizingMaskIntoConstraints = false
        conversationsTableView.backgroundColor = UIColor.white
        conversationsTableView.delegate = self
        conversationsTableView.dataSource = self
        conversationsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "ConversationsCell")
        
        return conversationsTableView
    }

}


extension View3: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ConnectionsCell", for: indexPath)
        cell.backgroundColor = UIColor.black
        
        cell.clipsToBounds = false
        cell.layer.cornerRadius = 19
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}


extension View3: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConversationsCell", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 6.5
    }
    
}





