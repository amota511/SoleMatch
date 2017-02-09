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
        cell.backgroundColor = UIColor.white
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 20
        
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.height))
        image.image = #imageLiteral(resourceName: "drake_fader")
        image.contentMode = .scaleAspectFill
        cell.addSubview(image)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("A connection cell was selected")
        
        let conversationView = createConversationView()
        
        
        
    }
    
    
}

extension View3: UITextViewDelegate {
    
    func createConversationView() -> UIView{
        let conversationView = UIView(frame: CGRect(x: self.view.frame.width, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        conversationView.backgroundColor = UIColor.white
        
        let headerView: UIView = {
            let headerView = UIView()
            headerView.backgroundColor = UIColor(red: 42/255.0, green: 47/255.0, blue: 46/255.0, alpha: 1.0)
            headerView.translatesAutoresizingMaskIntoConstraints = false
            return headerView
        }()
        
        conversationView.addSubview(headerView)
        
        headerView.topAnchor.constraint(equalTo: conversationView.topAnchor).isActive = true
        headerView.leftAnchor.constraint(equalTo: conversationView.leftAnchor).isActive = true
        headerView.widthAnchor.constraint(equalTo: conversationView.widthAnchor).isActive = true
        headerView.heightAnchor.constraint(equalTo: conversationView.heightAnchor, multiplier: 1/11).isActive = true
        
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
        
        let personNameLabel = UILabel()
        personNameLabel.text = "Drake"
        personNameLabel.textColor = UIColor(red: 215/255.0, green: 215/255.0, blue: 215/255.0, alpha: 1.0)
        personNameLabel.font = UIFont.boldSystemFont(ofSize: 22)
        personNameLabel.textAlignment = .center
        personNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        headerView.addSubview(personNameLabel)
        
        personNameLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 12).isActive = true
        personNameLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        personNameLabel.widthAnchor.constraint(equalTo: headerView.widthAnchor, multiplier: 1/3).isActive = true
        personNameLabel.heightAnchor.constraint(equalTo: headerView.heightAnchor, multiplier: 1/1.2).isActive = true
        
        let personProfileImage = UIImageView(frame: CGRect(x: self.view.frame.width - 50, y: 17.5, width: 40, height: 40))
        personProfileImage.image = #imageLiteral(resourceName: "drake_fader")
        personNameLabel.contentMode = .scaleAspectFit
        personProfileImage.clipsToBounds = true
        personProfileImage.layer.cornerRadius = 15
        
        headerView.addSubview(personProfileImage)
        

        
//        let textFooter = UIView(frame: CGRect(x: 0, y: self.view.frame.height - (self.view.frame.height * (1/12)), width: self.view.frame.width, height: (self.view.frame.height * (1/12))))
//        textFooter.backgroundColor = UIColor.lightGray
//
//        
//        conversationView.addSubview(textFooter)
//        
//
//        
//        let textView = UITextView(frame: CGRect(x: 2, y: ((self.view.frame.height * (1/12)) * (3/4)) / 6, width: self.view.frame.width * (6/7), height: (self.view.frame.height * (1/12)) * (3/4)))
//        
//        textView.clipsToBounds = true
//        textView.layer.cornerRadius = 15
//        textView.delegate = self
//        textView.text = "How fast can you get from zero to 100th street ?"
//        
//        textFooter.addSubview(textView)
//        
//        
        

        let talkButton = UIButton(type: .system)
        talkButton.frame = CGRect(x: 0, y: self.view.frame.height - (self.view.frame.height * (1/12)), width: self.view.frame.width, height: (self.view.frame.height * (1/12)))
        talkButton.backgroundColor = UIColor(red: 230 / 255.0, green: 70/255.0, blue: 30/255.0, alpha: 1.0)
        talkButton.tintColor = UIColor.white
        talkButton.setTitle("Connect", for: .normal)
        
        talkButton.titleLabel?.font = talkButton.titleLabel?.font.withSize(20)
        talkButton.addTarget(self, action: #selector(sendButtonPressed(sender:)), for: .touchUpInside)
        
        conversationView.addSubview(talkButton)

 
        
//        let messagesTableView = UITableView()
//        messagesTableView.allowsSelection = false
//        messagesTableView.delegate = self
//        messagesTableView.dataSource = self
//        messagesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MessagesTableViewCell")
//        messagesTableView.restorationIdentifier = "MessagesTableView"
//        messagesTableView.separatorColor = UIColor.clear
//        messagesTableView.separatorStyle = .none
//        messagesTableView.alwaysBounceHorizontal = false
//        messagesTableView.translatesAutoresizingMaskIntoConstraints = false
//        
//        conversationView.addSubview(messagesTableView)
//        
//        messagesTableView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
//        messagesTableView.leftAnchor.constraint(equalTo: conversationView.leftAnchor).isActive = true
//        messagesTableView.widthAnchor.constraint(equalTo: conversationView.widthAnchor).isActive = true
//        messagesTableView.bottomAnchor.constraint(equalTo: textFooter.topAnchor).isActive = true
//        

        self.view.addSubview(conversationView)
        
        //messagesTableView.scrollRectToVisible( CGRect(x: 0, y: 1000, width: messagesTableView.frame.width, height: messagesTableView.frame.height), animated: false)
        UIView.animate(withDuration: 0.5, animations: {
            
            conversationView.frame.origin.x = 0
            
        }, completion: {
            complete in
            //messagesTableView.scrollToRow(at: IndexPath(row: 4, section: 0), at: .bottom, animated: true)
        })
        return conversationView
    }
    
    func sendButtonPressed(sender: UIButton) {
        let connectButton = sender
        
        let buttonsView = UIView(frame: CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: self.view.frame.height / 2 - connectButton.frame.height / 2))
        buttonsView.backgroundColor = UIColor(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
        
        connectButton.superview!.addSubview(buttonsView)
        
        let negotiateButton = UIView(frame: CGRect(x: 10, y: 65, width: 80, height: 80))
        negotiateButton.backgroundColor = UIColor.green
        negotiateButton.layer.cornerRadius = negotiateButton.frame.width / 2
        negotiateButton.clipsToBounds = true
        
        let locationButton = UIView(frame: CGRect(x: self.view.frame.width / 2 - negotiateButton.frame.width / 2, y: 5, width: 80, height: 80))
        locationButton.backgroundColor = UIColor.yellow
        locationButton.layer.cornerRadius = locationButton.frame.width / 2
        locationButton.clipsToBounds = true
        
        let conditionButton = UIView(frame: CGRect(x: self.view.frame.width - (negotiateButton.frame.width) - 10, y: 65, width: 80, height: 80))
        conditionButton.backgroundColor = UIColor.red
        conditionButton.layer.cornerRadius = conditionButton.frame.width / 2
        conditionButton.clipsToBounds = true
        
        buttonsView.addSubview(negotiateButton)
        buttonsView.addSubview(locationButton)
        buttonsView.addSubview(conditionButton)
        
        let buyButton = UIView(frame: CGRect(x: self.view.frame.width / 2 - 160 / 2, y: buttonsView.frame.height / 2 - negotiateButton.frame.height + 20 , width: 160, height: 160))
        buyButton.backgroundColor = UIColor.orange
        buyButton.layer.cornerRadius = buyButton.frame.width / 2
        buyButton.clipsToBounds = true

        buttonsView.addSubview(buyButton)
        
        UIView.animate(withDuration: 0.5, animations: {
           () -> Void in
            
            connectButton.center.y = connectButton.superview!.center.y * 1.15
            buttonsView.center.y = connectButton.center.y + connectButton.frame.height / 2 + buttonsView.frame.height / 2
            
            
        }, completion: {
            (completed) -> Void in
            print("Movement completed")
        })
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
    
//    func creatConversationTableView() -> UITableView {
//        
//        
//        

    
}


extension View3: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "ConversationsCell", for: indexPath)
            
            let image = UIImageView(frame: CGRect(x: 6, y: cell.frame.height / 10, width: cell.frame.width / 6, height: cell.frame.height / 1.25))
            image.image = #imageLiteral(resourceName: "drake_fader")
            image.contentMode = .scaleAspectFill
            image.clipsToBounds = true
            image.layer.cornerRadius = 10
            cell.addSubview(image)
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        createConversationView()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 6.5
    }
    
}






