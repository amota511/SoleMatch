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
        let newCard = UIView()
        newCard.backgroundColor = UIColor.white
        
        newCard.layer.cornerRadius = 15
        
        newCard.frame.size.width = self.view.frame.width / 1.2
        newCard.frame.size.height = self.view.frame.height / 1.4
        newCard.center = CGPoint(x: self.view.frame.midX, y: self.view.frame.midY)
        
       
        let image = UIImage(named: "Pug_portrait")
        let photo = UIImageView(image: image)
        photo.clipsToBounds = true
        photo.layer.cornerRadius = 15
        photo.contentMode = .scaleToFill
        
        photo.frame.size.width = newCard.frame.width
        photo.frame.size.height = newCard.frame.height

        photo.center.x = newCard.center.x - 31.5
        photo.center.y = newCard.center.y - 95
        
        newCard.addSubview(photo)

        let labelView = UIView()
        labelView.backgroundColor = UIColor.lightText
        labelView.clipsToBounds = false
        labelView.layer.cornerRadius = 15
        photo.addSubview(labelView)
        
        labelView.translatesAutoresizingMaskIntoConstraints = false
        labelView.bottomAnchor.constraint(equalTo: photo.bottomAnchor, constant: -24).isActive = true
        labelView.centerXAnchor.constraint(equalTo: photo.centerXAnchor).isActive = true
        labelView.widthAnchor.constraint(equalTo: photo.widthAnchor, multiplier: 9/10).isActive = true
        labelView.heightAnchor.constraint(equalTo: photo.heightAnchor, multiplier: 1/10).isActive = true
        
        let nameLabel = UILabel()
        nameLabel.text = "Mr. Pug, 21"
        labelView.addSubview(nameLabel)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: labelView.topAnchor, constant: 6).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: labelView.leftAnchor, constant: 6).isActive = true
        nameLabel.widthAnchor.constraint(equalTo: labelView.widthAnchor, multiplier: 9/10).isActive = true
        nameLabel.heightAnchor.constraint(equalTo: labelView.heightAnchor, multiplier: 1/2.5).isActive = true
        
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
                    
                    UIView.animate(withDuration: 0.5, animations: {
                        view.center.x = -(self.cardA?.frame.width)!
                    }, completion: {
                        completionFlag in
                        view.removeFromSuperview()
                        
                        self.cardA = self.cardB
                        self.assignPanGesture(card: self.cardA!)
                        
                        self.cardB! = self.createNewCard()
                        self.cardB!.center.x = 187.5
                        let photo = self.cardB?.subviews.first as! UIImageView
                        photo.center.x = self.cardB!.center.x - 31.5
                        photo.center.y = self.cardB!.center.y - 95
                    })
                    
                }else if view.center.x > self.view.frame.width - 50 {

                    UIView.animate(withDuration: 0.5, animations: {
                        view.center.x = self.view.frame.width + (self.cardA?.frame.width)!
                    }, completion: {
                        completionFlag in
                        view.removeFromSuperview()
                        
                        self.cardA = self.cardB
                        self.assignPanGesture(card: self.cardA!)
                       
                        self.cardB! = self.createNewCard()
                        self.cardB!.center.x = 187.5
                        let photo = self.cardB?.subviews.first as! UIImageView
                        photo.center.x = self.cardB!.center.x - 31.5
                        photo.center.y = self.cardB!.center.y - 95
                        
                        
                    })
                    
                }else {
                    
                    UIView.animate(withDuration: 0.5, animations: {
                        sender.view!.center = CGPoint(x: self.view.frame.midX - (self.view.frame.midX / 1.5), y: self.view.frame.midY)
                        sender.view!.transform = sender.view!.transform.rotated(by: -atan2((self.cardA?.transform.b)!, (self.cardA?.transform.a)!))
                    })
                    sender.setTranslation(CGPoint(x: 0, y: 0), in: self.view)
                    
                }
                
            }
            
        }
        
    }

}
