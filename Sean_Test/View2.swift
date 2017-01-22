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

    override func viewDidLoad() {
        super.viewDidLoad()

        cardA = createNewCard()
        cardB = createNewCard()
        
        assignPanGesture(card: cardA!)
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
        
       
//        let image = UIImage(named: "Pug_portrait")
//        let photo = UIImageView(image: image)
//        photo.contentMode = .scaleToFill
//        
//        photo.frame.size.width = newCard.frame.width
//        photo.frame.size.height = newCard.frame.height
//        photo.center = CGPoint(x: self.view.frame.midX, y: self.view.frame.midY)
//        newCard.addSubview(photo)

        
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
                        DispatchQueue.main.async {
                            self.cardB! = self.createNewCard()
                        }
                        
                    })
                    
                }else if view.center.x > self.view.frame.width - 50 {

                    UIView.animate(withDuration: 0.5, animations: {
                        view.center.x = self.view.frame.width + (self.cardA?.frame.width)!
                    }, completion: {
                        completionFlag in
                        view.removeFromSuperview()
                        
                        self.cardA = self.cardB
                        self.assignPanGesture(card: self.cardA!)
                        DispatchQueue.main.async {
                            self.cardB! = self.createNewCard()
                        }
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
