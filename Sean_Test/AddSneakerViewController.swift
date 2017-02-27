//
//  AddSneakerViewController.swift
//  SoleMatch
//
//  Created by amota511 on 2/26/17.
//  Copyright © 2017 Aaron Motayne. All rights reserved.
//

import UIKit

class AddSneakerViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        createBlurView()
        
    }
    
    func createBlurView() {
        
        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        blurView.frame.origin.x = 0
        blurView.frame.origin.y = 0
        blurView.frame.size.width = self.view.bounds.width
        blurView.frame.size.height = self.view.bounds.height
        
        let dismissTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(removeView))
        blurView.addGestureRecognizer(dismissTapGestureRecognizer)
        
        self.view.addSubview(blurView)
        
        setupContainerView(blurView: blurView)
    }
    
    func setupContainerView(blurView: UIVisualEffectView){
        
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width / 1.25, height: self.view.frame.width / 1.25))
        containerView.center = CGPoint(x: self.view.center.x, y: self.view.center.y + self.view.center.y / 6)
        containerView.backgroundColor = UIColor.white //(red: 245.0/255.0, green: 245.0/255.0, blue: 245.0/255.0, alpha: 1.0)
        containerView.alpha = 0
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = 10
        
        
        self.view.addSubview(containerView)
        
        setupSneakerPhotosCV(containerView: containerView)
        
        setupAddKickLabel(blurView: blurView)
        
    }
    
    func animateContainerView(containerView: UIView, sneakerPhotosCV: UICollectionView) {
        UIView.animate(withDuration: 1.5, delay: 0.0, usingSpringWithDamping: 3.5, initialSpringVelocity: 0.5, options: [.curveEaseInOut] , animations: {
            
            containerView.frame.size = CGSize(width: self.view.frame.width * 0.95, height: self.view.frame.width * 0.95)
            containerView.center = self.view.center
            sneakerPhotosCV.bounds.origin.x = 0
            sneakerPhotosCV.bounds.origin.y = 0
            sneakerPhotosCV.frame.size.width = containerView.bounds.width
            sneakerPhotosCV.frame.size.height = containerView.bounds.height * (1/1.5)
            
            //self.addPhotoViewDescriptionLabel(containerView: containerView, collectionView: sneakerPhotosCV)
        }) { (completion) in
            
        }
        
        UIView.animate(withDuration: 0.5, animations: {
            
            containerView.alpha = 1.0
            
        }) { (completion) in
            
        }
    }
    
    func setupAddKickLabel(blurView: UIVisualEffectView) {
        let addKickLabel = UILabel()
        addKickLabel.text = "Add Kick"
        addKickLabel.textColor = UIColor.white
        addKickLabel.textAlignment = .center
        addKickLabel.attributedText = NSAttributedString(string: addKickLabel.text!, attributes: [NSUnderlineStyleAttributeName: 1, NSFontAttributeName : UIFont.systemFont(ofSize: 21.0)])
        
        blurView.addSubview(addKickLabel)
        addKickLabel.backgroundColor = UIColor.clear
        addKickLabel.alpha = 0
        addKickLabel.frame.size.width = blurView.frame.width
        addKickLabel.frame.size.height = blurView.frame.height / 16
        addKickLabel.center.x = blurView.center.x
        addKickLabel.frame.origin.y = -addKickLabel.frame.height
        
        UIView.animate(withDuration: 1.0, delay: 0.0, options: [.curveEaseInOut] , animations: {
            addKickLabel.alpha = 1.0
            addKickLabel.center.y = addKickLabel.frame.height * 2
        })
    }
    
    func setupSneakerPhotosCV(containerView: UIView){
        let sneakerPhotosCVLayout = UICollectionViewFlowLayout()
        sneakerPhotosCVLayout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        sneakerPhotosCVLayout.scrollDirection = .vertical
        
        
        let sneakerPhotosCV = UICollectionView(frame: CGRect(x: 0, y: 0, width: containerView.frame.width, height: (self.view.frame.width * 0.95) * (1/1.75)), collectionViewLayout: sneakerPhotosCVLayout)
        sneakerPhotosCVLayout.itemSize = CGSize(width: sneakerPhotosCVLayout.collectionView!.frame.width * (1/2.76), height: sneakerPhotosCVLayout.collectionView!.frame.height * (1/2.25))
        sneakerPhotosCV.dataSource = self
        sneakerPhotosCV.delegate = self
        sneakerPhotosCV.translatesAutoresizingMaskIntoConstraints = false
        sneakerPhotosCV.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "ConnectionsCell")
        sneakerPhotosCV.isScrollEnabled = false
        sneakerPhotosCV.backgroundColor = UIColor.white
        sneakerPhotosCV.allowsSelection = true

        containerView.addSubview(sneakerPhotosCV)
        
        animateContainerView(containerView: containerView, sneakerPhotosCV: sneakerPhotosCV)
        
    }
    
    func removeView() {
        print("removeView function sucessfully called.")
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ConnectionsCell", for: indexPath)
        cell.layer.cornerRadius = 2
        cell.backgroundColor = UIColor(red: 245.0/255.0, green: 245.0/255.0, blue: 245.0/255.0, alpha: 1.0)
        cell.layer.borderColor = UIColor(red: 225.0/255.0, green: 225.0/255.0, blue: 225.0/255.0, alpha: 1.0).cgColor
        cell.layer.borderWidth = 1
        
        addCameraImage(cell: cell)
        
        
        return cell
        
    }
    
    func addCameraImage(cell: UICollectionViewCell){
        
        let cameraImageView = UIImageView(image: #imageLiteral(resourceName: "white-camera-hi"))
        cameraImageView.contentMode = .scaleAspectFit
        cameraImageView.backgroundColor = UIColor.clear
        cameraImageView.frame.size.width = cell.bounds.width * 0.5
        cameraImageView.frame.size.height = cell.bounds.height * 0.5
        cameraImageView.center = CGPoint(x: cell.bounds.width / 2, y: cell.bounds.height / 2)
        
        cell.contentView.addSubview(cameraImageView)
    }
    
    func addPhotoViewDescriptionLabel(containerView: UIView, collectionView: UICollectionView){
        let descriptionLabel = UILabel()
        descriptionLabel.text = "Add up to 6 photos."
        descriptionLabel.textAlignment = .center
        descriptionLabel.textColor = UIColor(red: 245.0/255.0, green: 245.0/255.0, blue: 245.0/255.0, alpha: 1.0)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(descriptionLabel)
        
        descriptionLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 5).isActive = true
        descriptionLabel.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
        descriptionLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 1).isActive = true
        descriptionLabel.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 1/12).isActive = true
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
