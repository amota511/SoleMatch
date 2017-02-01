//
//  View2.swift
//  Sean_Test
//
//  Created by amota511 on 1/21/17.
//  Copyright © 2017 Aaron Motayne. All rights reserved.
//

import UIKit

class View2: UIViewController {

    var cardA: UIView?
    var cardB: UIView?
    
    var lastTranslationX: CGFloat = 0
    var scrollView: UIScrollView!
    
    lazy var leftButton: UIButton = {
        var button = UIButton()
        button.setTitle("Left", for: .normal)
       
        button.setTitleColor(UIColor.blue, for: .normal)
        button.addTarget(self, action: #selector(scrollLeft), for: .touchUpInside)
        return button
    }()
    
    lazy var rightButton: UIButton = {
        var button = UIButton()
        button.setTitle("Right", for: .normal)
        
        button.setTitleColor(UIColor.blue, for: .normal)
        button.addTarget(self, action: #selector(scrollRight), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cardA = createNewCard()
        cardB = createNewCard()
        
        assignPanGesture(card: cardA!)
        
        self.view.addSubview(rightButton)
        self.view.addSubview(leftButton)
        
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        leftButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 24).isActive = true
        leftButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive = true
        leftButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/12).isActive = true
        leftButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/15).isActive = true
        
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        rightButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 24).isActive = true
        rightButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12).isActive = true
        rightButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/8).isActive = true
        rightButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/15).isActive = true
        
    }

    
    override func viewDidAppear(_ animated: Bool) {
        self.scrollView = self.view.superview as! UIScrollView
    }
    
    func scrollLeft(){
        let v2Frame : CGRect = CGRect(x: 0, y: 0, width: Int(scrollView.frame.width / 3), height: Int(scrollView.frame.height))
        self.scrollView.scrollRectToVisible(v2Frame, animated: true)
        print("The left button was excecuted")
    }
    
    func scrollRight(){
        let v2Frame : CGRect = CGRect(x: Int((self.view.frame.width) * 2.67), y: 0, width: Int(scrollView.frame.width / 3), height: Int(scrollView.frame.height))
        self.scrollView.scrollRectToVisible(v2Frame, animated: true)
        print("The right button was excecuted")
    }
    
    func assignPanGesture(card: UIView) {
        let panGesture = UIPanGestureRecognizer()
        panGesture.addTarget(self, action: #selector(handleDragging(sender:)))
        panGesture.maximumNumberOfTouches = 1
        card.addGestureRecognizer(panGesture)
    }
    
    func createNewCard() -> UIView{
        
        let photo = UIImageView()
        DispatchQueue.global(qos: .background).async {
            do {
                let url = URL(string: "https://bossip.files.wordpress.com/2014/01/drakes-air-jordans-ovo-07.jpg?w=900&h=700")
                let data = try Data(contentsOf: url!)
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    photo.image = image
                }
            }catch{
              print("The Sneaker photo could not be loaded")
            }
        }
        
        let newCard = UIView()
        newCard.backgroundColor = UIColor.white
        
        newCard.layer.cornerRadius = 15
        
        newCard.frame.size.width = self.view.frame.width / 1.05
        newCard.frame.size.height = self.view.frame.height / 1.2
        newCard.center = CGPoint(x: self.view.frame.midX + 1, y: self.view.frame.midY + 45)
        
        photo.clipsToBounds = true
        photo.layer.cornerRadius = 15
        photo.contentMode = .scaleAspectFit
        
        photo.frame.size.width = newCard.frame.width
        photo.frame.size.height = newCard.frame.height

        photo.center.x = newCard.center.x - 10
        photo.center.y = newCard.center.y - 115
        
        newCard.addSubview(photo)

        let labelView = UIView()
        labelView.backgroundColor = UIColor.lightText
        labelView.clipsToBounds = false
        labelView.layer.cornerRadius = 15
        photo.addSubview(labelView)
        
        labelView.translatesAutoresizingMaskIntoConstraints = false
        labelView.bottomAnchor.constraint(equalTo: photo.bottomAnchor, constant: -6).isActive = true
        labelView.centerXAnchor.constraint(equalTo: photo.centerXAnchor).isActive = true
        labelView.widthAnchor.constraint(equalTo: photo.widthAnchor, multiplier: 19.5/20).isActive = true
        labelView.heightAnchor.constraint(equalTo: photo.heightAnchor, multiplier: 1/10).isActive = true
        
        let nameLabel = UILabel()
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .left
        nameLabel.lineBreakMode = .byWordWrapping
        nameLabel.text = "Brand: Jordan\nCondition: Deadstock "
        labelView.addSubview(nameLabel)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: labelView.topAnchor).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: labelView.leftAnchor).isActive = true
        nameLabel.widthAnchor.constraint(equalTo: labelView.widthAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalTo: labelView.heightAnchor).isActive = true
        
        let priceLabel = UILabel()
        priceLabel.frame = CGRect(x: 250, y: 5, width: 100, height: 35)
        priceLabel.text = "$250"
        //priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.textAlignment = .center
        priceLabel.lineBreakMode = .byWordWrapping
        priceLabel.numberOfLines = 0
        priceLabel.backgroundColor = UIColor.lightGray
        priceLabel.clipsToBounds = true
        priceLabel.layer.cornerRadius = 10
        
        newCard.addSubview(priceLabel)
        
        
        self.view.insertSubview(newCard, at: 0)

        return newCard
    }
    
    
    func handleDragging(sender: UIPanGestureRecognizer){
        
        let translation = sender.translation(in: self.view)
        if let view = sender.view {
            view.center = CGPoint(x:view.center.x + translation.x, y:view.center.y + translation.y)
            
            if view.center.x > lastTranslationX {
                view.transform = view.transform.rotated(by: 0.01)
                
            }else if view.center.x < lastTranslationX {
                view.transform = view.transform.rotated(by: -0.01)
            }
            
            lastTranslationX = view.center.x
        }
        
        sender.setTranslation(CGPoint(x: 0, y: 0), in: self.view)
        
        if sender.state == .ended {
            
            if let view = sender.view {
                
                if view.center.x < 65 {
                    
                    UIView.animate(withDuration: 0.2, animations: {
                        view.center.x = -(self.cardA?.frame.width)!
                    }, completion: {
                        completionFlag in
                        view.removeFromSuperview()
                        
                        self.cardA = self.cardB
                        self.assignPanGesture(card: self.cardA!)
                        
                        self.cardB! = self.createNewCard()
                        self.cardB!.center.x = 187.5
                        let photo = self.cardB?.subviews.first as! UIImageView
                        photo.center.x = self.cardB!.center.x - 9.5
                        photo.center.y = self.cardB!.center.y - 115
                    })
                    
                }else if view.center.x > self.view.frame.width - 50 {

                    UIView.animate(withDuration: 0.2, animations: {
                        view.center.x = self.view.frame.width + (self.cardA?.frame.width)!
                    }, completion: {
                        completionFlag in
                        view.removeFromSuperview()
                        
                        self.cardA = self.cardB
                        self.assignPanGesture(card: self.cardA!)
                       
                        self.cardB! = self.createNewCard()
                        self.cardB!.center.x = 187.5
                        let photo = self.cardB?.subviews.first as! UIImageView
                        photo.center.x = self.cardB!.center.x - 9.5
                        photo.center.y = self.cardB!.center.y - 115
                    })
                    
                }else {
                    
                    UIView.animate(withDuration: 0.5, animations: {
                        sender.view!.center = CGPoint(x: self.cardB!.center.x, y: self.cardB!.center.y )
                        sender.view!.transform = sender.view!.transform.rotated(by: -atan2((self.cardA?.transform.b)!, (self.cardA?.transform.a)!))
                    })
                    sender.setTranslation(CGPoint(x: 0, y: 0), in: self.view)
                    
                }
                
            }
            
        }
        
    }

}
