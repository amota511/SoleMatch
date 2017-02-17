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
    
    var filterSelectionViewCenterX: NSLayoutConstraint!
    
    lazy var leftButton: UIButton = {
        var button = UIButton()
        //button.setTitle("Left", for: .normal)
       button.setImage(#imageLiteral(resourceName: "Shoe Box"), for: .normal)
        //button.setTitleColor(UIColor.blue, for: .normal)
        button.addTarget(self, action: #selector(scrollLeft), for: .touchUpInside)
        return button
    }()
    
    lazy var rightButton: UIButton = {
        var button = UIButton()
        //button.setTitle("Right", for: .normal)
        button.setImage(#imageLiteral(resourceName: "Location Love"), for: .normal)
        //button.setTitleColor(UIColor.blue, for: .normal)
        button.addTarget(self, action: #selector(scrollRight), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cardA = createNewCard()
        cardB = createNewCard()
        
        assignPanGesture(card: cardA!)
        
        let headerView = UIView()
        headerView.backgroundColor = UIColor(red: 55/255.0, green: 61/255.0, blue: 60/255.0, alpha: 1.0)
            
        // Background color for sole match font UIColor(red: 225 / 255.0, green: 40/255.0, blue: 30/255.0, alpha: 1.0)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(headerView)
        
        headerView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        headerView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        headerView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        headerView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/11).isActive = true
        let soleMatchLabel = UILabel()
        soleMatchLabel.text = "Sole Match"
        soleMatchLabel.textAlignment = .center
        //soleMatchLabel.font = UIFont.boldSystemFont(ofSize: 20)
        soleMatchLabel.textColor = UIColor(red: 225 / 255.0, green: 40/255.0, blue: 30/255.0, alpha: 1.0)
        soleMatchLabel.translatesAutoresizingMaskIntoConstraints = false
        soleMatchLabel.font = UIFont(name: "Pacifico-Regular", size: 24)
        
        headerView.addSubview(soleMatchLabel)
        headerView.addSubview(rightButton)
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
        
        soleMatchLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 24).isActive = true
        soleMatchLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        soleMatchLabel.widthAnchor.constraint(equalTo: headerView.widthAnchor, multiplier: 1/2.5).isActive = true
        soleMatchLabel.heightAnchor.constraint(equalTo: headerView.heightAnchor, multiplier: 1/2).isActive = true
        
        let cardFilter = UIView()
        
        cardFilter.backgroundColor = UIColor(red: 42/255.0, green: 47/255.0, blue: 46/255.0, alpha: 1.0)
        cardFilter.layer.cornerRadius = 10
        cardFilter.clipsToBounds = true
        cardFilter.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(cardFilter)
        
        cardFilter.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 9).isActive = true
        cardFilter.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        cardFilter.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1/1.85).isActive = true
        cardFilter.heightAnchor.constraint(equalTo: headerView.heightAnchor, multiplier: 1/2).isActive = true
        
        let filterSelectionView = UIView()
        filterSelectionView.backgroundColor = UIColor(red: 230 / 255.0, green: 70/255.0, blue: 30/255.0, alpha: 1.0)
        filterSelectionView.alpha = 1.0
        filterSelectionView.layer.cornerRadius = 10
        filterSelectionView.clipsToBounds = true
        filterSelectionView.isUserInteractionEnabled = true
        filterSelectionView.restorationIdentifier = "filterSelectionView"
        filterSelectionView.translatesAutoresizingMaskIntoConstraints = false
        
        cardFilter.addSubview(filterSelectionView)
        
        let button1 = UIButton()
        button1.restorationIdentifier = "Button1"
        button1.backgroundColor = UIColor.clear
        button1.setTitle("202", for: .normal)
        //button1.setImage(#imageLiteral(resourceName: "Gerber Baby"), for: .normal)
        button1.layer.cornerRadius = 10
        button1.clipsToBounds = true
        button1.addTarget(self, action: #selector(changeFilter(sender:)), for: .touchUpInside)
        button1.translatesAutoresizingMaskIntoConstraints = false
        
        cardFilter.addSubview(button1)
        
        button1.topAnchor.constraint(equalTo: cardFilter.topAnchor).isActive = true
        button1.leftAnchor.constraint(equalTo: cardFilter.leftAnchor).isActive = true
        button1.heightAnchor.constraint(equalTo: cardFilter.heightAnchor).isActive = true
        button1.widthAnchor.constraint(equalTo: cardFilter.widthAnchor, multiplier: 1/3.2).isActive = true
        
        let button2 = UIButton()
        button2.restorationIdentifier = "Button2"
        button2.backgroundColor = UIColor.clear
        button2.setTitle("505", for: .normal)
        button2.layer.cornerRadius = 10
        button2.clipsToBounds = true
        button2.addTarget(self, action: #selector(changeFilter(sender:)), for: .touchUpInside)
        button2.translatesAutoresizingMaskIntoConstraints = false
        
        cardFilter.addSubview(button2)
        
        button2.topAnchor.constraint(equalTo: cardFilter.topAnchor).isActive = true
        button2.centerXAnchor.constraint(equalTo: cardFilter.centerXAnchor).isActive = true
        button2.heightAnchor.constraint(equalTo: cardFilter.heightAnchor).isActive = true
        button2.widthAnchor.constraint(equalTo: cardFilter.widthAnchor, multiplier: 1/3.2).isActive = true
        
        let button3 = UIButton()
        button3.restorationIdentifier = "Button3"
        button3.backgroundColor = UIColor.clear
        button3.setTitle("1010", for: .normal)
        button3.layer.cornerRadius = 10
        button3.clipsToBounds = true
        button3.addTarget(self, action: #selector(changeFilter(sender:)), for: .touchUpInside)
        button3.translatesAutoresizingMaskIntoConstraints = false
        
        cardFilter.addSubview(button3)
        
        button3.topAnchor.constraint(equalTo: cardFilter.topAnchor).isActive = true
        button3.rightAnchor.constraint(equalTo: cardFilter.rightAnchor).isActive = true
        button3.heightAnchor.constraint(equalTo: cardFilter.heightAnchor).isActive = true
        button3.widthAnchor.constraint(equalTo: cardFilter.widthAnchor, multiplier: 1/3.2).isActive = true
        
        
        
        
        filterSelectionView.topAnchor.constraint(equalTo: cardFilter.topAnchor).isActive = true
        filterSelectionViewCenterX = filterSelectionView.centerXAnchor.constraint(equalTo: cardFilter.centerXAnchor)
        filterSelectionViewCenterX.isActive = true
        filterSelectionView.heightAnchor.constraint(equalTo: cardFilter.heightAnchor).isActive = true
        filterSelectionView.widthAnchor.constraint(equalTo: cardFilter.widthAnchor, multiplier: 1/3.2).isActive = true
        
    }
    
    func changeFilter(sender: UIButton){
        let cardFilter = sender.superview!
        var filterSelectionView: UIView? = nil
        
        for view in cardFilter.subviews {
            if view.restorationIdentifier == "filterSelectionView" {
                filterSelectionView = view
            }
        }
        
        UIView.animate(withDuration: 0.5, animations: {
            
            filterSelectionView?.center.x = sender.center.x
            if sender.restorationIdentifier == "Button1" {
                print("Good idea")
                filterSelectionView?.backgroundColor = UIColor(red: 220 / 255.0, green: 35/255.0, blue: 45/255.0, alpha: 1.0)
            }else if sender.restorationIdentifier == "Button2" {
                print("Great idea")
                filterSelectionView?.backgroundColor = UIColor(red: 230 / 255.0, green: 70/255.0, blue: 30/255.0, alpha: 1.0)
            }else if sender.restorationIdentifier == "Button3"{
                print("Best idea")
                filterSelectionView?.backgroundColor = UIColor(red: 240 / 255.0, green: 110/255.0, blue: 40/255.0, alpha: 1.0)
            }
            //filterSelectionView?.backgroundColor = UIColor(red: 225 / 255.0, green: 40/255.0, blue: 30/255.0, alpha: 1.0)
            
        })
        
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
        
        let backgroundPhoto = UIImageView()
        
        
        let photo = UIImageView()
        
        DispatchQueue.global(qos: .background).async {
            do {
                let url = URL(string: "https://s-media-cache-ak0.pinimg.com/736x/5f/67/4f/5f674f244275237e63642c7f8afc5a4c.jpg")
                let data = try Data(contentsOf: url!)
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    backgroundPhoto.image = image
                    photo.image = image
                }
            }catch{
                print("The Sneaker photo could not be loaded")
            }
        }
        
        let newCard = UIView()
        newCard.backgroundColor = UIColor.white
        
        newCard.layer.cornerRadius = 15
        
        newCard.frame.size.width = self.view.bounds.width / 1.05
        newCard.frame.size.height = self.view.bounds.height / 1.23
        newCard.center = CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height / 2 + 45)
        
        backgroundPhoto.clipsToBounds = true
        backgroundPhoto.layer.cornerRadius = 15
        backgroundPhoto.contentMode = .scaleAspectFill
        
        backgroundPhoto.frame.size.width = newCard.bounds.width
        backgroundPhoto.frame.size.height = newCard.bounds.height
        
        backgroundPhoto.frame.origin.x = newCard.bounds.origin.x
        backgroundPhoto.frame.origin.y = newCard.bounds.origin.y
        
        newCard.addSubview(backgroundPhoto)
        
        
//        let blur = UIBlurEffect(style: .dark)
//        let vibrancyEffect = UIVibrancyEffect(blurEffect: blur)
//        let blurView = UIVisualEffectView(effect: vibrancyEffect)
//        
//        blurView.clipsToBounds = true
//        blurView.layer.cornerRadius = 15
//        blurView.alpha = 1
        
        
        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        blurView.frame = backgroundPhoto.bounds
        
        backgroundPhoto.addSubview(blurView)
        
        
//        let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
//        let vibrancyEffectView = UIVisualEffectView(effect: vibrancyEffect)
        
        //newCard.addSubview(blurView)
        //vibrancyEffectView.contentView.addSubview(blurView)
        //blurView.contentView.addSubview(vibrancyEffectView)
        
        
//        blurView.clipsToBounds = true
//        blurView.layer.cornerRadius = 15
        
        
        //blurView.effect = blurEffect
        //backgroundPhoto.addSubview(blurView)
        
        blurView.contentView.addSubview(photo)
        //newCard.addSubview(photo)
        
        photo.clipsToBounds = true
        photo.layer.cornerRadius = 15
        photo.contentMode = .scaleAspectFit
        
        photo.frame.size.width = newCard.frame.width
        photo.frame.size.height = newCard.frame.height

        photo.center.x = newCard.bounds.origin.x + newCard.bounds.width / 2
        photo.center.y = newCard.bounds.origin.y + newCard.bounds.height / 2
        
        

        let labelView = UIView()
        photo.addSubview(labelView)
        labelView.backgroundColor = UIColor.lightText
        labelView.clipsToBounds = true
        labelView.layer.cornerRadius = 15
        photo.addSubview(labelView)
        
        labelView.translatesAutoresizingMaskIntoConstraints = false
        labelView.bottomAnchor.constraint(equalTo: photo.bottomAnchor, constant: -2).isActive = true
        labelView.centerXAnchor.constraint(equalTo: photo.centerXAnchor).isActive = true
        labelView.widthAnchor.constraint(equalTo: photo.widthAnchor, multiplier: 19.5/20).isActive = true
        labelView.heightAnchor.constraint(equalTo: photo.heightAnchor, multiplier: 1/8).isActive = true
        
        let nameLabel = UILabel()
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .left
        nameLabel.lineBreakMode = .byWordWrapping
        nameLabel.clipsToBounds = true
        nameLabel.layer.cornerRadius = 15
        nameLabel.text = "Name: OvO 10  \nCondition: Deadstock \nSize: 12"
        labelView.addSubview(nameLabel)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: labelView.topAnchor).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: labelView.leftAnchor, constant: 2).isActive = true
        nameLabel.widthAnchor.constraint(equalTo: labelView.widthAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalTo: labelView.heightAnchor).isActive = true
        
        let priceLabel = UILabel()
        priceLabel.frame = CGRect(x: newCard.bounds.width - 110, y: 10, width: 100, height: 35)
        priceLabel.text = "$250"
        priceLabel.textAlignment = .center
        priceLabel.lineBreakMode = .byWordWrapping
        priceLabel.numberOfLines = 0
        priceLabel.backgroundColor = UIColor.lightGray
        priceLabel.clipsToBounds = true
        priceLabel.layer.cornerRadius = 10
        
        blurView.contentView.addSubview(priceLabel)
        //newCard.addSubview(priceLabel)
        
        //self.view.addSubview(newCard)
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
                        view.center.x = -self.cardA!.frame.width
                    }, completion: {
                        completionFlag in
                        view.removeFromSuperview()
                        
                        self.cardA = self.cardB
                        self.assignPanGesture(card: self.cardA!)
                        
                        self.cardB! = self.createNewCard()
                        self.cardB!.center.x = self.view.bounds.origin.x + self.view.bounds.width / 2
                    })
                    
                }else if view.center.x > self.view.frame.width - 50 {

                    UIView.animate(withDuration: 0.2, animations: {
                        view.frame.origin.x = self.view.frame.width + self.cardA!.frame.width
                    }, completion: {
                        completionFlag in
                        view.removeFromSuperview()
                        DispatchQueue.main.async {
                            self.cardA = self.cardB
                            self.assignPanGesture(card: self.cardA!)
                            
                            self.cardB! = self.createNewCard()
                            self.cardB!.center.x = self.view.bounds.origin.x + self.view.bounds.width / 2

                        }
                        
                    })
                    
                }else {
                    
                    UIView.animate(withDuration: 0.5, animations: {
                        sender.view!.center = CGPoint(x: self.cardB!.center.x, y: self.cardB!.center.y )
                        sender.view!.transform = sender.view!.transform.rotated(by: -atan2(self.cardA!.transform.b, self.cardA!.transform.a))
                    })
                    sender.setTranslation(CGPoint(x: 0, y: 0), in: self.view)
                    
                }
                
            }
            
        }
        
    }

}
