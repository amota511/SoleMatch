//
//  View3.swift
//  Sean_Test
//
//  Created by amota511 on 1/21/17.
//  Copyright © 2017 Aaron Motayne. All rights reserved.
//

import UIKit

class CommunicationViewController: UIViewController {

    var scrollView: UIScrollView!
    var isConnectViewHidden = true
    var sneakers = [Sneaker]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let connectionsLabel: UILabel = {
            let label = UILabel()
            label.text = "Connections"
            label.textAlignment = .left
            label.backgroundColor = UIColor.white
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        for i in 0...5 {
            sneakers.append(Sneaker())
            sneakers[i].photos = [UIImage]()
            sneakers[i].price = 150 + (20 * i)
        }
        
        sneakers[0].photos?.append(#imageLiteral(resourceName: "Air Mag"))
        sneakers[1].photos?.append(#imageLiteral(resourceName: "Yeezy Red Stripe"))
        sneakers[2].photos?.append(#imageLiteral(resourceName: "Yeezy Orange Stripe"))
        sneakers[3].photos?.append(#imageLiteral(resourceName: "OvO 10"))
        sneakers[4].photos?.append(#imageLiteral(resourceName: "Concord 11"))

        
        self.view.addSubview(connectionsLabel)
        
        connectionsLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 5).isActive = true
        connectionsLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        connectionsLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        connectionsLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/22).isActive = true
        
        let connectionsCollectionView = createConnectionsCV()
        
        self.view.addSubview(connectionsCollectionView)
        
        connectionsCollectionView.topAnchor.constraint(equalTo: connectionsLabel.bottomAnchor).isActive = true
        connectionsCollectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        connectionsCollectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        connectionsCollectionView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/6).isActive = true
        
        
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
    
    func createConnectionsCV() -> UICollectionView {
        
        let connectionsLayout = UICollectionViewFlowLayout()
        connectionsLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        connectionsLayout.scrollDirection = .horizontal
        

        let connectionsCollectionView = UICollectionView(frame: CGRect(x: 0, y: 100, width: self.view.frame.width, height: self.view.frame.height * (1/6)), collectionViewLayout: connectionsLayout)
        connectionsLayout.itemSize = CGSize(width: connectionsLayout.collectionView!.frame.height * (5/6), height: connectionsLayout.collectionView!.frame.height * (5/6))
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
        conversationsTableView.allowsMultipleSelection = false
        conversationsTableView.delegate = self
        conversationsTableView.dataSource = self
//        conversationsTableView.register(ConversationsTVCell.self, forCellReuseIdentifier: "ConversationsCell")
        
        return conversationsTableView
    }

}


extension CommunicationViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ConnectionsCell", for: indexPath)
        cell.backgroundColor = UIColor.white
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 20
        
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.height))
        image.image = sneakers[indexPath.row].photos?[0]
        image.contentMode = .scaleAspectFill
        cell.addSubview(image)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("A connection cell was selected")
        
        //let conversationView = createConversationView()
        
        let baseView = self.parent as! BaseVC
        baseView.showConversation()
        
    }
    
}


extension CommunicationViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 16
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        if tableView.restorationIdentifier == "MessagesTableView" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MessagesTableViewCell", for: indexPath)
            
            let rand1 = arc4random() % 255
            let rand2 = arc4random() % 255
            let rand3 = arc4random() % 255
            
            cell.backgroundColor = UIColor(red: CGFloat(rand1) / 255.0, green: CGFloat(rand2)/255.0, blue: CGFloat(rand3)/255.0, alpha: 1.0)
            
            if indexPath.row == 18 {
                cell.backgroundColor = UIColor.black
            }
            return cell
        }else {
            tableView.register(ConversationsTVCell.self, forCellReuseIdentifier: "ConversationsCell")
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ConversationsCell", for: indexPath) as! ConversationsTVCell
            let sneaker = sneakers[(indexPath.row + 3) % sneakers.count]
            
            let sneakerImage = cell.sneakerImage
            sneakerImage.image = sneakers[(indexPath.row + 3) % 5].photos?[0]
            sneakerImage.contentMode = .scaleAspectFill
            sneakerImage.clipsToBounds = true
            sneakerImage.layer.cornerRadius = 10
            sneakerImage.translatesAutoresizingMaskIntoConstraints = false

            cell.addSubview(sneakerImage)
            
            sneakerImage.leftAnchor.constraint(equalTo: cell.leftAnchor, constant: 6).isActive = true
            sneakerImage.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
            sneakerImage.widthAnchor.constraint(equalTo: cell.widthAnchor, multiplier: 1/5).isActive = true
            sneakerImage.heightAnchor.constraint(equalTo: cell.widthAnchor, multiplier: 1/5).isActive = true
            
            let sneakerName = cell.sneakerName
            sneakerName.text = "Shoe Name"
            sneakerName.textColor = UIColor.black
            sneakerName.textAlignment = .left
            sneakerName.translatesAutoresizingMaskIntoConstraints = false
            
            cell.addSubview(sneakerName)
            
            sneakerName.topAnchor.constraint(equalTo: sneakerImage.topAnchor, constant: 0).isActive = true
            sneakerName.leftAnchor.constraint(equalTo: sneakerImage.rightAnchor, constant: 12).isActive = true
            sneakerName.widthAnchor.constraint(equalTo: cell.widthAnchor, multiplier: 1/1.25).isActive = true
            sneakerName.heightAnchor.constraint(equalTo: cell.heightAnchor, multiplier: 1/5).isActive = true
            
            let sneakerCondition = cell.sneakerCondition
            sneakerCondition.text = "Shoe Condition"
            sneakerCondition.textColor = UIColor.black
            sneakerCondition.textAlignment = .left
            sneakerCondition.translatesAutoresizingMaskIntoConstraints = false
            
            cell.addSubview(sneakerCondition)
            
            sneakerCondition.centerYAnchor.constraint(equalTo: sneakerImage.centerYAnchor, constant: 0).isActive = true
            sneakerCondition.leftAnchor.constraint(equalTo: sneakerImage.rightAnchor, constant: 12).isActive = true
            sneakerCondition.widthAnchor.constraint(equalTo: cell.widthAnchor, multiplier: 1/1.25).isActive = true
            sneakerCondition.heightAnchor.constraint(equalTo: cell.heightAnchor, multiplier: 1/5).isActive = true
            
            let sneakerPrice = cell.sneakerPrice
            sneakerPrice.text = "$" + String(sneaker.price!)
            sneakerPrice.textColor = UIColor.black
            sneakerPrice.textAlignment = .left
            sneakerPrice.translatesAutoresizingMaskIntoConstraints = false
            
            cell.addSubview(sneakerPrice)
            
            sneakerPrice.bottomAnchor.constraint(equalTo: sneakerImage.bottomAnchor, constant: 0).isActive = true
            sneakerPrice.leftAnchor.constraint(equalTo: sneakerImage.rightAnchor, constant: 12).isActive = true
            sneakerPrice.widthAnchor.constraint(equalTo: cell.widthAnchor, multiplier: 1/1.25).isActive = true
            sneakerPrice.heightAnchor.constraint(equalTo: cell.heightAnchor, multiplier: 1/5).isActive = true
            

            let hourGlassTimer = UIImageView(image: #imageLiteral(resourceName: "hourglass_colored"))
            hourGlassTimer.contentMode = .scaleAspectFit
            hourGlassTimer.translatesAutoresizingMaskIntoConstraints = false
            
            cell.contentView.addSubview(hourGlassTimer)
            
            hourGlassTimer.topAnchor.constraint(equalTo: sneakerName.topAnchor).isActive = true
            hourGlassTimer.rightAnchor.constraint(equalTo: cell.rightAnchor, constant: -10).isActive = true
            hourGlassTimer.widthAnchor.constraint(equalTo: cell.widthAnchor, multiplier: 1/7).isActive = true
            hourGlassTimer.heightAnchor.constraint(equalTo: cell.heightAnchor, multiplier: 2/4).isActive = true
            
            let timerLabel = cell.timerLabel
            timerLabel.text = "16 Hrs Remaining"
            timerLabel.textColor = UIColor.black
            timerLabel.textAlignment = .center
            timerLabel.font = timerLabel.font.withSize(11)
            timerLabel.translatesAutoresizingMaskIntoConstraints = false
            
            cell.addSubview(timerLabel)
            
            timerLabel.bottomAnchor.constraint(equalTo: sneakerPrice.bottomAnchor, constant: 0).isActive = true
            timerLabel.rightAnchor.constraint(equalTo: cell.rightAnchor, constant: 3.5).isActive = true
            timerLabel.widthAnchor.constraint(equalTo: cell.widthAnchor, multiplier: 1/3).isActive = true
            timerLabel.heightAnchor.constraint(equalTo: cell.heightAnchor, multiplier: 1/6).isActive = true
            
            cell.selectionStyle = .none
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let baseView = self.parent as! BaseVC
        baseView.showConversation()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 4.5
    }
    
}
