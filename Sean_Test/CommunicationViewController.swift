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
        
        let baseView = self.parent as! ViewController
        baseView.showConversation()
        
    }
    
    
}

extension CommunicationViewController {
    
    //-(self.view.frame.height * (1/11))
    //+ (self.view.frame.height * (1/11))
    func createConversationView() -> UIView{
        self.view.clipsToBounds = false
        let conversationView = UIView(frame: CGRect(x: self.view.frame.width, y: (-(self.view.frame.height * (1/11)) - 5), width: self.view.frame.width, height: self.view.frame.height + (self.view.frame.height * (1/11)) + 5))
        conversationView.backgroundColor = UIColor(red: 215/255.0, green: 215/255.0, blue: 215/255.0, alpha: 1.0)
        conversationView.clipsToBounds = false
        
        
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
            button.setTitleColor(UIColor(red: 215/255.0, green: 215/255.0, blue: 215/255.0, alpha: 1.0), for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(dissmissConversationsView(sender:)), for: .touchUpInside)
            return button
        }()
        
        headerView.addSubview(backButton)
        
        backButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor, constant: 0).isActive = true
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
        
        personNameLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor, constant: 0).isActive = true
        personNameLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        personNameLabel.widthAnchor.constraint(equalTo: headerView.widthAnchor, multiplier: 1/3).isActive = true
        personNameLabel.heightAnchor.constraint(equalTo: headerView.heightAnchor, multiplier: 1/1.2).isActive = true
        
        let personProfileImage = UIImageView(frame: CGRect(x: self.view.frame.width - 50, y: 8, width: 40, height: 40))
        personProfileImage.image = #imageLiteral(resourceName: "drake_fader")
        personNameLabel.contentMode = .scaleAspectFit
        personProfileImage.clipsToBounds = true
        personProfileImage.layer.cornerRadius = 15
        
        headerView.addSubview(personProfileImage)
        

        let connectButton = UIButton(type: .system)
        connectButton.frame = CGRect(x: 0, y: conversationView.frame.height - (self.view.frame.height * (1/12)), width: self.view.frame.width, height: (self.view.frame.height * (1/12)))
        connectButton.backgroundColor = UIColor(red: 230 / 255.0, green: 70/255.0, blue: 30/255.0, alpha: 1.0)
        connectButton.tintColor = UIColor(red: 215/255.0, green: 215/255.0, blue: 215/255.0, alpha: 1.0)
        connectButton.setTitle("Connect", for: .normal)
        
        connectButton.titleLabel?.font = connectButton.titleLabel?.font.withSize(20)
        connectButton.addTarget(self, action: #selector(sendButtonPressed(sender:)), for: .touchUpInside)
        
        conversationView.addSubview(connectButton)

 
        
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
        
        if isConnectViewHidden == true {
            
            let buttonsView = UIView(frame: CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: self.view.frame.height / 2 - connectButton.frame.height / 2))
            buttonsView.backgroundColor = UIColor(red: 215/255, green: 215/255, blue: 215/255, alpha: 1)
            buttonsView.restorationIdentifier = "buttonview"
            connectButton.superview!.addSubview(buttonsView)

            
            let negotiateButton = UIView(frame: CGRect(x: 10, y: 65, width: 80, height: 80))
            negotiateButton.backgroundColor = UIColor(red: 220 / 255.0, green: 35/255.0, blue: 45/255.0, alpha: 1.0)
            negotiateButton.layer.cornerRadius = negotiateButton.frame.width / 2
            negotiateButton.clipsToBounds = true
            negotiateButton.restorationIdentifier = "negotiateButton"
            let negotiateTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(negotiateButtonTapped(sender:)))
            negotiateTapRecognizer.numberOfTapsRequired = 1
            negotiateTapRecognizer.numberOfTouchesRequired = 1
            negotiateButton.addGestureRecognizer(negotiateTapRecognizer)
            
            let negotiateLabel1 = UILabel()
            negotiateLabel1.text = "Negotiate"
            negotiateLabel1.font = negotiateLabel1.font.withSize(12)
            negotiateLabel1.textColor = UIColor(red: 215/255.0, green: 215/255.0, blue: 215/255.0, alpha: 1.0)
            negotiateLabel1.translatesAutoresizingMaskIntoConstraints = false
            negotiateLabel1.textAlignment = .center
            negotiateLabel1.restorationIdentifier = "negotiate label"
            negotiateButton.addSubview(negotiateLabel1)
            
            
            negotiateLabel1.bottomAnchor.constraint(equalTo: negotiateButton.bottomAnchor, constant: -12).isActive = true
            negotiateLabel1.centerXAnchor.constraint(equalTo: negotiateButton.centerXAnchor).isActive = true
            negotiateLabel1.widthAnchor.constraint(equalTo: negotiateButton.widthAnchor, multiplier: 1/1.2).isActive = true
            negotiateLabel1.heightAnchor.constraint(equalTo: negotiateButton.heightAnchor, multiplier: 1/4).isActive = true
            
            let locationButton = UIView(frame: CGRect(x: self.view.frame.width / 2 - negotiateButton.frame.width / 2, y: 5, width: 80, height: 80))
            locationButton.backgroundColor = UIColor(red: 230 / 255.0, green: 70/255.0, blue: 30/255.0, alpha: 1.0)
            locationButton.layer.cornerRadius = locationButton.frame.width / 2
            locationButton.clipsToBounds = true
            locationButton.restorationIdentifier = "locationButton"
            let locationTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(locationButtonTapped(sender:)))
            locationTapRecognizer.numberOfTapsRequired = 1
            locationTapRecognizer.numberOfTouchesRequired = 1
            locationButton.addGestureRecognizer(locationTapRecognizer)
            
            let locationLabel = UILabel()
            locationLabel.text = "Location"
            locationLabel.font = locationLabel.font.withSize(12)
            locationLabel.textColor = UIColor(red: 215/255.0, green: 215/255.0, blue: 215/255.0, alpha: 1.0)
            locationLabel.translatesAutoresizingMaskIntoConstraints = false
            locationLabel.textAlignment = .center
            locationLabel.restorationIdentifier = "locationLabel"
            locationButton.addSubview(locationLabel)
            
            
            locationLabel.bottomAnchor.constraint(equalTo: locationButton.bottomAnchor, constant: -12).isActive = true
            locationLabel.centerXAnchor.constraint(equalTo: locationButton.centerXAnchor).isActive = true
            locationLabel.widthAnchor.constraint(equalTo: locationButton.widthAnchor, multiplier: 1/1.2).isActive = true
            locationLabel.heightAnchor.constraint(equalTo: locationButton.heightAnchor, multiplier: 1/4).isActive = true
            
            
            let conditionButton = UIView(frame: CGRect(x: self.view.frame.width - (negotiateButton.frame.width) - 10, y: 65, width: 80, height: 80))
            conditionButton.backgroundColor = UIColor(red: 240 / 255.0, green: 110/255.0, blue: 40/255.0, alpha: 1.0)
            conditionButton.layer.cornerRadius = conditionButton.frame.width / 2
            conditionButton.clipsToBounds = true
            conditionButton.restorationIdentifier = "conditionButton"
            let conditionTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(conditionButtonTapped(sender:)))
            conditionTapRecognizer.numberOfTapsRequired = 1
            conditionTapRecognizer.numberOfTouchesRequired = 1
            conditionButton.addGestureRecognizer(conditionTapRecognizer)
            
            let conditionLabel = UILabel()
            conditionLabel.text = "Condition"
            conditionLabel.font = conditionLabel.font.withSize(12)
            conditionLabel.textColor = UIColor(red: 215/255.0, green: 215/255.0, blue: 215/255.0, alpha: 1.0)
            conditionLabel.translatesAutoresizingMaskIntoConstraints = false
            conditionLabel.textAlignment = .center
            conditionLabel.restorationIdentifier = "conditionLabel"
            conditionButton.addSubview(conditionLabel)
            
            
            conditionLabel.bottomAnchor.constraint(equalTo: conditionButton.bottomAnchor, constant: -12).isActive = true
            conditionLabel.centerXAnchor.constraint(equalTo: conditionButton.centerXAnchor).isActive = true
            conditionLabel.widthAnchor.constraint(equalTo: conditionButton.widthAnchor, multiplier: 1/1.2).isActive = true
            conditionLabel.heightAnchor.constraint(equalTo: conditionButton.heightAnchor, multiplier: 1/4).isActive = true
            
            buttonsView.addSubview(negotiateButton)
            buttonsView.addSubview(locationButton)
            buttonsView.addSubview(conditionButton)
            
            let buyButton = UIView(frame: CGRect(x: self.view.frame.width / 2 - 160 / 2, y: buttonsView.frame.height / 2 - negotiateButton.frame.height + 20 , width: 160, height: 160))
            buyButton.backgroundColor = UIColor(red: 42/255.0, green: 47/255.0, blue: 46/255.0, alpha: 1.0)
            buyButton.layer.cornerRadius = buyButton.frame.width / 4
            buyButton.clipsToBounds = true
            buyButton.restorationIdentifier = "buyButton"
            let buyTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(buyButtonTapped(sender:)))
            buyTapRecognizer.numberOfTapsRequired = 1
            buyTapRecognizer.numberOfTouchesRequired = 1
            buyButton.addGestureRecognizer(buyTapRecognizer)
            
            let buyImage = UIImageView(image: #imageLiteral(resourceName: "hand_shake"))
            buyImage.contentMode = .scaleAspectFit
            buyImage.translatesAutoresizingMaskIntoConstraints = false
            
            buyButton.addSubview(buyImage)
            
            buyImage.topAnchor.constraint(equalTo: buyButton.topAnchor, constant: 10).isActive = true
            buyImage.centerXAnchor.constraint(equalTo: buyButton.centerXAnchor).isActive = true
            buyImage.widthAnchor.constraint(equalTo: buyButton.widthAnchor, multiplier: 5/6).isActive = true
            buyImage.heightAnchor.constraint(equalTo: buyButton.heightAnchor, multiplier: 1/1.5).isActive = true
            
            let buyLabel = UILabel()
            buyLabel.text = "Buy"
            buyLabel.font = buyLabel.font.withSize(20)
            buyLabel.textColor = UIColor(red: 215/255.0, green: 215/255.0, blue: 215/255.0, alpha: 1.0)
            buyLabel.translatesAutoresizingMaskIntoConstraints = false
            buyLabel.textAlignment = .center
            buyLabel.restorationIdentifier = "buyLabel"
            buyButton.addSubview(buyLabel)
            
            
            buyLabel.bottomAnchor.constraint(equalTo: buyButton.bottomAnchor, constant: -12).isActive = true
            buyLabel.centerXAnchor.constraint(equalTo: buyButton.centerXAnchor).isActive = true
            buyLabel.widthAnchor.constraint(equalTo: buyButton.widthAnchor, multiplier: 1/1.2).isActive = true
            buyLabel.heightAnchor.constraint(equalTo: buyButton.heightAnchor, multiplier: 1/4).isActive = true
            
            buttonsView.addSubview(buyButton)
            
            UIView.animate(withDuration: 0.5, animations: {
                () -> Void in
                
                connectButton.center.y = connectButton.superview!.center.y * 1.15
                buttonsView.center.y = connectButton.center.y + connectButton.frame.height / 2 + buttonsView.frame.height / 2
                
                
            }, completion: {
                (completed) -> Void in
                print("Movement completed")
            })
            
            isConnectViewHidden = !isConnectViewHidden
        }else {
            
            UIView.animate(withDuration: 0.5, animations: {
                () -> Void in
                
                connectButton.frame.origin.y = self.view.frame.height - connectButton.frame.height
                var buttonsView: UIView?
                
                for views in (connectButton.superview?.subviews)! {
                    if views.restorationIdentifier == "buttonview" {
                        buttonsView = views
                    }
                }
                buttonsView?.frame.origin.y = self.view.frame.height
                buttonsView?.backgroundColor = UIColor.blue
                
            }, completion: {
                (completed) -> Void in
                print("Movement completed")
                var buttonsView: UIView?
                
                for views in (connectButton.superview?.subviews)! {
                    if views.restorationIdentifier == "buttonview" {
                        buttonsView = views
                    }
                }
                
                buttonsView?.removeFromSuperview()
            })
            isConnectViewHidden = !isConnectViewHidden
        }
    }
    
    func negotiateButtonTapped(sender: UITapGestureRecognizer) {
        print("Negotiate button tapped")
        let negotiateButton = sender.view!
        
        var locationButton: UIView? = nil
        var conditionButton: UIView? = nil
        var buyButton: UIView? = nil
        
        let buttonView: UIView = negotiateButton.superview!
        
        for view in negotiateButton.superview!.subviews {
            if view.restorationIdentifier == "locationButton" {
                locationButton = view
            }else if view.restorationIdentifier == "conditionButton" {
                conditionButton = view
            }else if view.restorationIdentifier == "buyButton" {
                buyButton = view
            }
            
        }
        
        
        UIView.animate(withDuration: 0.5,
                       animations:
            {
                locationButton?.center.x = self.view.frame.width + locationButton!.frame.width
                conditionButton?.center.x = self.view.frame.width + conditionButton!.frame.width
                buyButton?.center.x = self.view.frame.width + buyButton!.frame.width
                
            }, completion:
            {
                (true) in
                UIView.animate(withDuration: 0.35,
                               animations:
                    {
                        
                        negotiateButton.center.x = buttonView.center.x

                }, completion:
                    {
                        (true) in
                        UIView.animate(withDuration: 0.35,
                                       animations:
                            {
                                negotiateButton.frame.origin.y = buttonView.frame.height * (1/24)
                                negotiateButton.frame.size.height = buttonView.frame.height * (3/4)
                                negotiateButton.frame.origin.x = buttonView.frame.width * (1/8)
                                negotiateButton.frame.size.width = buttonView.frame.width * (3/4)
                        }, completion:
                        {
                            (true) in
                                
                                let cancelButton = UIButton(type: .roundedRect)
                                cancelButton.clipsToBounds = true
                                cancelButton.layer.cornerRadius = 5
                                cancelButton.setTitle("X", for: .normal)
                                cancelButton.addTarget(self, action: #selector(self.cancelButtonTapped(sender:)), for: .touchUpInside)
                                cancelButton.tintColor = UIColor.white
                                cancelButton.backgroundColor = UIColor.lightGray
                                cancelButton.frame = CGRect(x: negotiateButton.frame.width - 20 - 20, y: 20, width: 20, height: 20)
                                negotiateButton.addSubview(cancelButton)
                        })
                
        })
                
                print("Buttons moved")
            }
        )
        
    }
    
    func locationButtonTapped(sender: UITapGestureRecognizer) {
        
        let locationButton = sender.view!
        
        var negotiateButton: UIView? = nil
        var conditionButton: UIView? = nil
        var buyButton: UIView? = nil
        
        let buttonView: UIView = locationButton.superview!
        
        for view in locationButton.superview!.subviews {
            if view.restorationIdentifier == "negotiateButton" {
                negotiateButton = view
            }else if view.restorationIdentifier == "conditionButton" {
                conditionButton = view
            }else if view.restorationIdentifier == "buyButton" {
                buyButton = view
            }
            
        }
        
        
        UIView.animate(withDuration: 0.5,
                       animations:
            {
                negotiateButton?.center.y = self.view.frame.height + negotiateButton!.frame.height / 2
                conditionButton?.center.y = self.view.frame.height + conditionButton!.frame.height / 2
                buyButton?.center.y = self.view.frame.height + buyButton!.frame.height / 2
                
        }, completion:
            {
                (true) in
                UIView.animate(withDuration: 0.35,
                               animations:
                    {
                        
                        locationButton.frame.origin.y = 65
                        
                }, completion:
                    {
                        (true) in
                        UIView.animate(withDuration: 0.35,
                                       animations:
                            {
                                locationButton.frame.origin.y = buttonView.frame.height * (1/24)
                                locationButton.frame.size.height = buttonView.frame.height * (3/4)
                                locationButton.frame.origin.x = buttonView.frame.width * (1/8)
                                locationButton.frame.size.width = buttonView.frame.width * (3/4)
                        }, completion:
                            {
                                (true) in
                                
                                let cancelButton = UIButton(type: .roundedRect)
                                cancelButton.clipsToBounds = true
                                cancelButton.layer.cornerRadius = 5
                                cancelButton.setTitle("X", for: .normal)
                                cancelButton.addTarget(self, action: #selector(self.cancelButtonTapped(sender:)), for: .touchUpInside)
                                cancelButton.tintColor = UIColor.white
                                cancelButton.backgroundColor = UIColor.lightGray
                                cancelButton.frame = CGRect(x: locationButton.frame.width - 20 - 20, y: 20, width: 20, height: 20)
                                locationButton.addSubview(cancelButton)
                        })
                        
                })
                
                print("Buttons moved")
        })
    }
    
    func conditionButtonTapped(sender: UITapGestureRecognizer) {

        let conditionButton = sender.view!
        
        var negotiateButton: UIView? = nil
        var locationButton: UIView? = nil
        var buyButton: UIView? = nil
        
        let buttonView: UIView = conditionButton.superview!
        
        for view in conditionButton.superview!.subviews {
            if view.restorationIdentifier == "negotiateButton" {
                negotiateButton = view
            }else if view.restorationIdentifier == "locationButton" {
                locationButton = view
            }else if view.restorationIdentifier == "buyButton" {
                buyButton = view
            }
            
        }
        
        
        UIView.animate(withDuration: 0.5,
                       animations:
            {
                negotiateButton?.center.x = 0 - negotiateButton!.frame.width
                locationButton?.center.x = 0 - locationButton!.frame.height
                buyButton?.center.x = 0 - buyButton!.frame.height
                
        }, completion:
            {
                (true) in
                UIView.animate(withDuration: 0.35,
                               animations:
                    {
                        
                        conditionButton.center.x = buttonView.center.x
                        
                }, completion:
                    {
                        (true) in
                        UIView.animate(withDuration: 0.35,
                                       animations:
                            {
                                conditionButton.frame.origin.y = buttonView.frame.height * (1/24)
                                conditionButton.frame.size.height = buttonView.frame.height * (3/4)
                                conditionButton.frame.origin.x = buttonView.frame.width * (1/8)
                                conditionButton.frame.size.width = buttonView.frame.width * (3/4)
                        }, completion:
                            {
                                (true) in
                                
                                let cancelButton = UIButton(type: .roundedRect)
                                cancelButton.clipsToBounds = true
                                cancelButton.layer.cornerRadius = 5
                                cancelButton.setTitle("X", for: .normal)
                                cancelButton.addTarget(self, action: #selector(self.cancelButtonTapped(sender:)), for: .touchUpInside)
                                cancelButton.tintColor = UIColor.white
                                cancelButton.backgroundColor = UIColor.lightGray
                                cancelButton.frame = CGRect(x: conditionButton.frame.width - 20 - 20, y: 20, width: 20, height: 20)
                                conditionButton.addSubview(cancelButton)
                        })
                        
                })
                
                print("Buttons moved")
        })
        
        print("condition button tapped")
    }
    
    func buyButtonTapped(sender: UITapGestureRecognizer) {
        
        let buyButton = sender.view!
        
        var negotiateButton: UIView? = nil
        var locationButton: UIView? = nil
        var conditionButton: UIView? = nil
        
        let buttonView: UIView = buyButton.superview!
        
        for view in buyButton.superview!.subviews {
            if view.restorationIdentifier == "negotiateButton" {
                negotiateButton = view
            }else if view.restorationIdentifier == "locationButton" {
                locationButton = view
            }else if view.restorationIdentifier == "conditionButton" {
                conditionButton = view
            }
            
        }
        
        
        UIView.animate(withDuration: 0.5,
                       animations:
            {
                negotiateButton?.center.x = 0 - negotiateButton!.frame.width
                locationButton?.frame.origin.y = self.view.frame.height
                conditionButton?.center.x = self.view.frame.width + conditionButton!.frame.width
                
        }, completion:
            {
                (true) in
                UIView.animate(withDuration: 0.35,
                               animations:
                    {
                        
                        buyButton.frame.origin.y = buttonView.frame.height / 2 - negotiateButton!.frame.height - 30
                        
                }, completion:
                    {
                        (true) in
                        UIView.animate(withDuration: 0.35,
                                       animations:
                            {
                                
                                buyButton.frame.origin.y = buttonView.frame.height * (1/24)
                                buyButton.frame.size.height = buttonView.frame.height * (3/4)
                                buyButton.frame.origin.x = buttonView.frame.width * (1/8)
                                buyButton.frame.size.width = buttonView.frame.width * (3/4)
                                //buyButton.layer.cornerRadius = 30
                        }, completion:
                            {
                                (true) in
                                
                                let cancelButton = UIButton(type: .roundedRect)
                                cancelButton.clipsToBounds = true
                                cancelButton.layer.cornerRadius = 5
                                cancelButton.setTitle("X", for: .normal)
                                cancelButton.addTarget(self, action: #selector(self.cancelButtonTapped(sender:)), for: .touchUpInside)
                                cancelButton.tintColor = UIColor.white
                                cancelButton.backgroundColor = UIColor.lightGray
                                cancelButton.frame = CGRect(x: buyButton.frame.width - 20 - 20, y: 20, width: 20, height: 20)
                                buyButton.addSubview(cancelButton)
                        })
                        
                })
                
                print("Buttons moved")
        })
        
        print("buy button tapped")
    }
    
    func cancelButtonTapped(sender: UIButton) {
        print("Cancel button tapped")
        
        if sender.superview!.restorationIdentifier == "negotiateButton" {
        let negotiateButton = sender.superview!
        
        for view in negotiateButton.subviews {
            view.removeFromSuperview()
        }
        
        var locationButton: UIView? = nil
        var conditionButton: UIView? = nil
        var buyButton: UIView? = nil
        
        let buttonView: UIView = negotiateButton.superview!
        
        for view in negotiateButton.superview!.subviews {
            if view.restorationIdentifier == "locationButton" {
                locationButton = view
            }else if view.restorationIdentifier == "conditionButton" {
                conditionButton = view
            }else if view.restorationIdentifier == "buyButton" {
                buyButton = view
            }
            
        }
        
        UIView.animate(withDuration: 0.5, animations: {
            () -> Void in
            negotiateButton.frame.origin.x = 10
            negotiateButton.frame.origin.y = 65
            negotiateButton.frame.size.height = 80
            negotiateButton.frame.size.width = 80
            
            locationButton!.frame.origin.x = self.view.frame.width / 2 - negotiateButton.frame.width / 2
            locationButton!.frame.origin.y = 5
            
            conditionButton!.frame.origin.x = self.view.frame.width - (negotiateButton.frame.width) - 10
            conditionButton!.frame.origin.y = 65
            
            buyButton!.frame.origin.x = (self.view.frame.width / 2) - (160 / 2)
            buyButton!.frame.origin.y = buttonView.frame.height / 2 - negotiateButton.frame.height + 20
            
        }, completion: {
            (completed) -> Void in
            print("Movement completed again")
        })
        }else if sender.superview!.restorationIdentifier == "locationButton" {
            let locationButton = sender.superview!
            
            for view in locationButton.subviews {
                view.removeFromSuperview()
            }
            
            var negotiateButton: UIView? = nil
            var conditionButton: UIView? = nil
            var buyButton: UIView? = nil
            
            let buttonView: UIView = locationButton.superview!
            
            for view in locationButton.superview!.subviews {
                if view.restorationIdentifier == "negotiateButton" {
                    negotiateButton = view
                }else if view.restorationIdentifier == "conditionButton" {
                    conditionButton = view
                }else if view.restorationIdentifier == "buyButton" {
                    buyButton = view
                }
                
            }
            
            UIView.animate(withDuration: 0.5, animations: {
                () -> Void in
                locationButton.frame.origin.x = self.view.frame.width / 2 - negotiateButton!.frame.width / 2
                locationButton.frame.origin.y = 5
                locationButton.frame.size.height = 80
                locationButton.frame.size.width = 80
                
                negotiateButton!.frame.origin.x = 10
                negotiateButton!.frame.origin.y = 65
                
                conditionButton!.frame.origin.x = self.view.frame.width - (negotiateButton!.frame.width) - 10
                conditionButton!.frame.origin.y = 65
                
                buyButton!.frame.origin.x = (self.view.frame.width / 2) - (160 / 2)
                buyButton!.frame.origin.y = buttonView.frame.height / 2 - negotiateButton!.frame.height + 20
                
            }, completion: {
                (completed) -> Void in
                print("Movement completed again")
            })
        
        
        }else if sender.superview!.restorationIdentifier == "conditionButton" {
            let conditionButton = sender.superview!
            
            for view in conditionButton.subviews {
                view.removeFromSuperview()
            }
            
            var negotiateButton: UIView? = nil
            var locationButton: UIView? = nil
            var buyButton: UIView? = nil
            
            let buttonView: UIView = conditionButton.superview!
            
            for view in conditionButton.superview!.subviews {
                if view.restorationIdentifier == "negotiateButton" {
                    negotiateButton = view
                }else if view.restorationIdentifier == "locationButton" {
                    locationButton = view
                }else if view.restorationIdentifier == "buyButton" {
                    buyButton = view
                }
                
            }
            
            UIView.animate(withDuration: 0.5, animations: {
                () -> Void in
                conditionButton.frame.origin.x = self.view.frame.width - (negotiateButton!.frame.width) - 10
                conditionButton.frame.origin.y = 65
                conditionButton.frame.size.height = 80
                conditionButton.frame.size.width = 80
                
                negotiateButton!.frame.origin.x = 10
                negotiateButton!.frame.origin.y = 65
                
                locationButton!.frame.origin.x = self.view.frame.width / 2 - negotiateButton!.frame.width / 2
                locationButton!.frame.origin.y = 5
                
                buyButton!.frame.origin.x = (self.view.frame.width / 2) - (160 / 2)
                buyButton!.frame.origin.y = buttonView.frame.height / 2 - negotiateButton!.frame.height + 20
                
            }, completion: {
                (completed) -> Void in
                print("Movement completed again")
            })
        
        
        
        }else if sender.superview!.restorationIdentifier == "buyButton" {
            let buyButton = sender.superview!
            
            for view in buyButton.subviews {
                view.removeFromSuperview()
            }
            
            var negotiateButton: UIView? = nil
            var locationButton: UIView? = nil
            var conditionButton: UIView? = nil
            
            let buttonView: UIView = buyButton.superview!
            
            for view in buyButton.superview!.subviews {
                if view.restorationIdentifier == "negotiateButton" {
                    negotiateButton = view
                }else if view.restorationIdentifier == "conditionButton" {
                    conditionButton = view
                }else if view.restorationIdentifier == "locationButton" {
                    locationButton = view
                }
                
            }
            
            UIView.animate(withDuration: 0.5, animations: {
                () -> Void in
                buyButton.frame.origin.x = (self.view.frame.width / 2) - (160 / 2)
                buyButton.frame.origin.y = buttonView.frame.height / 2 - negotiateButton!.frame.height + 20
                buyButton.frame.size.height = 160
                buyButton.frame.size.width = 160
                //buyButton.layer.cornerRadius = 80
                
                negotiateButton!.frame.origin.x = 5
                negotiateButton!.frame.origin.y = 65
                
                locationButton!.frame.origin.x = self.view.frame.width / 2 - locationButton!.frame.width / 2
                locationButton!.frame.origin.y = 5
                
                conditionButton!.frame.origin.x = self.view.frame.width - conditionButton!.frame.width - 10
                conditionButton!.frame.origin.y = 65

            }, completion: {
                (completed) -> Void in
                print("Movement completed again")
            })
        }
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
            
            let sneakerSize = cell.sneakerPrice
            sneakerSize.text = String(sneaker.price!)
            sneakerSize.textColor = UIColor.black
            sneakerSize.textAlignment = .left
            sneakerSize.translatesAutoresizingMaskIntoConstraints = false
            
            cell.addSubview(sneakerSize)
            
            sneakerSize.bottomAnchor.constraint(equalTo: sneakerImage.bottomAnchor, constant: 0).isActive = true
            sneakerSize.leftAnchor.constraint(equalTo: sneakerImage.rightAnchor, constant: 12).isActive = true
            sneakerSize.widthAnchor.constraint(equalTo: cell.widthAnchor, multiplier: 1/1.25).isActive = true
            sneakerSize.heightAnchor.constraint(equalTo: cell.heightAnchor, multiplier: 1/5).isActive = true
            

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
            
            timerLabel.bottomAnchor.constraint(equalTo: sneakerSize.bottomAnchor, constant: 0).isActive = true
            timerLabel.rightAnchor.constraint(equalTo: cell.rightAnchor, constant: 3.5).isActive = true
            timerLabel.widthAnchor.constraint(equalTo: cell.widthAnchor, multiplier: 1/3).isActive = true
            timerLabel.heightAnchor.constraint(equalTo: cell.heightAnchor, multiplier: 1/6).isActive = true
            
            cell.selectionStyle = .none
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let baseView = self.parent as! ViewController
        baseView.showConversation()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 4.5
    }
    
}
