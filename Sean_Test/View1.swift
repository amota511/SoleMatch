//
//  View1.swift
//  Sean_Test
//
//  Created by amota511 on 1/21/17.
//  Copyright © 2017 Aaron Motayne. All rights reserved.
//

import UIKit

class View1: UIViewController {

    var scrollView: UIScrollView!
    
    var userImage: UIImageView!
    var userName: UILabel!
    var collectionButton: UILabel!
    var myCollection: UICollectionView!
    var myCollectionHeight: NSLayoutConstraint!
    var isMyCollectionDroppedDown: Bool = false
    var preferencesButton: UILabel!
    var myPreferences: UIView!
    var myPreferencesHeight: NSLayoutConstraint!
    var isMyPreferencesDroppedDown: Bool = false
    var myPrefSize: UILabel!
    var myPrefSliderValue: Float!
    var imageArray = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createUserImage()
        createUserNameLabel()
        createCollectionButton()
        createMyCollectionView()
        createPreferencesButton()
        createPreferencesView()
 

        imageArray.append(#imageLiteral(resourceName: "Air Mag"))
        imageArray.append(#imageLiteral(resourceName: "Yeezy Red Stripe"))
        imageArray.append(#imageLiteral(resourceName: "Yeezy Orange Stripe"))
        imageArray.append(#imageLiteral(resourceName: "OvO 10"))
        imageArray.append(#imageLiteral(resourceName: "Concord 11"))

    }
    
    
    func createUserImage() {
        
        
        let url = URL(string: "https://thefader-res.cloudinary.com/images/w_2400,c_limit,f_auto,q_auto:best/F100_Drake_Cover_FINAL_tuqta0/drake-views-from-the-6-cover-story-interview.jpg")
        let userImage = UIImageView()
        
        do {
            
            let data = try Data(contentsOf: url!)
            
            let userPhoto = UIImage(data: data)
            userImage.image = userPhoto
            
        }catch {
            
        }
        
        userImage.translatesAutoresizingMaskIntoConstraints = false
        userImage.clipsToBounds = true
        
        userImage.layer.borderWidth = 3.0
        userImage.layer.borderColor = UIColor.white.cgColor
        
        self.view.addSubview(userImage)
        
        userImage.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20).isActive = true
        userImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        userImage.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1/3).isActive = true
        userImage.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1/3).isActive = true
        
        userImage.layer.cornerRadius = (self.view.frame.width / 6)
        self.userImage = userImage
    }
    
    func createUserNameLabel() {
        
        let userNameLabel = UILabel()
        userNameLabel.text = "Drake"
        userNameLabel.textAlignment = .center
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(userNameLabel)
        
        userNameLabel.topAnchor.constraint(equalTo: userImage.bottomAnchor).isActive = true
        userNameLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        userNameLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        userNameLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/10).isActive = true
        
        self.userName = userNameLabel
    }
    
    func createCollectionButton() {
        
        let collectionButton = UILabel()
        collectionButton.text = "My Collection"
        collectionButton.textAlignment = .left
        collectionButton.backgroundColor = UIColor.white
        collectionButton.translatesAutoresizingMaskIntoConstraints = false
        collectionButton.isUserInteractionEnabled = true
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(myCollectionTapRecognizer))
        collectionButton.addGestureRecognizer(tapGesture)
        
        
        self.view.addSubview(collectionButton)
        
        collectionButton.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 5).isActive = true
        collectionButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        collectionButton.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        collectionButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/18).isActive = true
        
        self.collectionButton = collectionButton
        
    }
    
    func myCollectionTapRecognizer(){
        self.myCollectionHeight.isActive = false
        if !isMyCollectionDroppedDown {
            self.myCollectionHeight = myCollection.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/2.5)
            isMyCollectionDroppedDown = !isMyCollectionDroppedDown
        }else{
            self.myCollectionHeight = myCollection.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0)
            isMyCollectionDroppedDown = !isMyCollectionDroppedDown
        }

        self.myCollectionHeight.isActive = true
        
    }
    
    func createMyCollectionView() {
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        collectionLayout.scrollDirection = .vertical
        
        let collectionCV = UICollectionView(frame: CGRect(x: 0, y: 300, width: self.view.frame.width, height: self.view.frame.height * (1/5)), collectionViewLayout: collectionLayout)
        collectionLayout.itemSize = CGSize(width: collectionLayout.collectionView!.frame.width * (1/3.4), height: collectionLayout.collectionView!.frame.height * (5/6))
        collectionCV.dataSource = self
        collectionCV.delegate = self
        collectionCV.translatesAutoresizingMaskIntoConstraints = false
        collectionCV.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "ConnectionsCell")
        collectionCV.isScrollEnabled = true
        collectionCV.backgroundColor = UIColor(red: 42/255.0, green: 47/255.0, blue: 46/255.0, alpha: 1.0)
        collectionCV.showsHorizontalScrollIndicator = false
        collectionCV.allowsSelection = true
        collectionCV.alwaysBounceHorizontal = false
        collectionCV.allowsMultipleSelection = false
        collectionCV.alwaysBounceVertical = true
        collectionCV.bounces = true
        collectionCV.restorationIdentifier = "CollectionCV"
        
        self.view.addSubview(collectionCV)
        self.myCollectionHeight = collectionCV.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0)
        self.myCollectionHeight.isActive = true
        collectionCV.topAnchor.constraint(equalTo: collectionButton.bottomAnchor).isActive = true
        collectionCV.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        collectionCV.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        
        
        self.myCollection = collectionCV
    }
    
    func createPreferencesButton() {
        
        let preferencesButton = UILabel()
        preferencesButton.text = "My Preferences"
        preferencesButton.textAlignment = .left
        preferencesButton.backgroundColor = UIColor.white
        preferencesButton.translatesAutoresizingMaskIntoConstraints = false
        preferencesButton.isUserInteractionEnabled = true
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(myPreferencesTapRecognizer))
        preferencesButton.addGestureRecognizer(tapGesture)
        
        
        self.view.addSubview(preferencesButton)
        
        preferencesButton.topAnchor.constraint(equalTo: myCollection.bottomAnchor, constant: 1).isActive = true
        preferencesButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        preferencesButton.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        preferencesButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/18).isActive = true
        
        self.preferencesButton = preferencesButton
    }
    
    func myPreferencesTapRecognizer(){
        self.myPreferencesHeight.isActive = false
        if !isMyPreferencesDroppedDown {
            self.myPreferencesHeight = myPreferences.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/3)
            isMyPreferencesDroppedDown = !isMyPreferencesDroppedDown
            for view in myPreferences.subviews {
                view.isHidden = false
            }
        }else{
            self.myPreferencesHeight = myPreferences.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0)
            isMyPreferencesDroppedDown = !isMyPreferencesDroppedDown
            for view in myPreferences.subviews {
                view.isHidden = true
            }
        }
        
        self.myPreferencesHeight.isActive = true
    }
    
    func createPreferencesView() {
        
        let preferencesView = UIView()
        preferencesView.backgroundColor = UIColor.white
        preferencesView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(preferencesView)
        
        self.myPreferencesHeight = preferencesView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0)
        self.myPreferencesHeight.isActive = true
        preferencesView.topAnchor.constraint(equalTo: preferencesButton.bottomAnchor, constant: 1).isActive = true
        preferencesView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        preferencesView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        
        
        self.myPreferences = preferencesView
        
        let sizeLabel = UILabel()
        sizeLabel.textAlignment = .left
        sizeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        preferencesView.addSubview(sizeLabel)
        
        sizeLabel.topAnchor.constraint(equalTo: preferencesView.topAnchor, constant: 5).isActive = true
        sizeLabel.centerXAnchor.constraint(equalTo: preferencesView.centerXAnchor).isActive = true
        sizeLabel.widthAnchor.constraint(equalTo: preferencesView.widthAnchor).isActive = true
        sizeLabel.heightAnchor.constraint(equalTo: preferencesView.heightAnchor, multiplier: 1/8).isActive = true
        
        self.myPrefSize = sizeLabel
        
        let sizeSlider = UISlider()
        sizeSlider.translatesAutoresizingMaskIntoConstraints = false
        sizeSlider.minimumValue = 1
        sizeSlider.maximumValue = 15
        
        sizeSlider.setValue(6, animated: true)
        self.myPrefSliderValue = sizeSlider.value
        sizeSlider.maximumTrackTintColor = UIColor(red: 42/255.0, green: 47/255.0, blue: 46/255.0, alpha: 1.0)
        sizeSlider.tintColor = UIColor(red: 230 / 255.0, green: 70/255.0, blue: 30/255.0, alpha: 1.0)
        
        sizeLabel.text = "Size: \(sizeSlider.value)"
        
        sizeSlider.addTarget(self, action: #selector(sliderMoved(sender:)), for: .valueChanged)
        
        preferencesView.addSubview(sizeSlider)
        sizeSlider.topAnchor.constraint(equalTo: sizeLabel.bottomAnchor, constant: 0).isActive = true
        sizeSlider.centerXAnchor.constraint(equalTo: preferencesView.centerXAnchor).isActive = true
        sizeSlider.widthAnchor.constraint(equalTo: preferencesView.widthAnchor, multiplier: 1/1.025).isActive = true
        sizeSlider.heightAnchor.constraint(equalTo: preferencesView.heightAnchor, multiplier: 1/6).isActive = true
        
        for view in myPreferences.subviews {
            view.isHidden = true
        }
    }
    
    func sliderMoved(sender: UISlider) {
        
        let flooredValue = floorf(sender.value)
        
        if sender.value < flooredValue + 0.4 {
            sender.setValue( flooredValue, animated: false)
            myPrefSliderValue = flooredValue
        } else if sender.value > flooredValue + 0.4 && sender.value < floorf(sender.value) + 0.6 {
            sender.setValue( flooredValue + 0.5, animated: false)
            myPrefSliderValue = flooredValue + 0.5
        } else if sender.value > flooredValue + 0.6 {
            sender.setValue( floorf(sender.value) + 1.0, animated: false)
            myPrefSliderValue = flooredValue + 1
        }
        
        print(sender.value)
        myPrefSize.text = "Size: \(myPrefSliderValue!)"
    }

    func scrollRight(){
        let v2Frame : CGRect = CGRect(x: Int((self.view.frame.width) * 1.67), y: 0, width: Int(scrollView.frame.width / 3), height: Int(scrollView.frame.height))
        scrollView.scrollRectToVisible(v2Frame, animated: true)
        print("The right button was excecuted")
    }

    override func viewDidAppear(_ animated: Bool) {
        self.scrollView = self.view.superview as! UIScrollView
    }
    
}

extension View1: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ConnectionsCell", for: indexPath)
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 20
        
        if indexPath.row < imageArray.count {
            let imageView = UIImageView()
            imageView.image = imageArray[indexPath.row]
            imageView.contentMode = .scaleAspectFill
            imageView.translatesAutoresizingMaskIntoConstraints = false
            cell.addSubview(imageView)
            imageView.topAnchor.constraint(equalTo: cell.topAnchor).isActive = true
            imageView.leftAnchor.constraint(equalTo: cell.leftAnchor).isActive = true
            imageView.heightAnchor.constraint(equalTo: cell.heightAnchor).isActive = true
            imageView.widthAnchor.constraint(equalTo: cell.widthAnchor).isActive = true
        
        } else if indexPath.row == imageArray.count {
            cell.backgroundColor = UIColor(red: 55/255.0, green: 61/255.0, blue: 60/255.0, alpha: 1.0)
            
            let imageView = UIImageView()
            imageView.image = #imageLiteral(resourceName: "White Plus")
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            cell.addSubview(imageView)
            imageView.centerXAnchor.constraint(equalTo: cell.centerXAnchor).isActive = true
            imageView.centerYAnchor.constraint(equalTo: cell.centerYAnchor, constant: -5).isActive = true
            imageView.heightAnchor.constraint(equalTo: cell.heightAnchor, multiplier: 1/2.5).isActive = true
            imageView.widthAnchor.constraint(equalTo: cell.widthAnchor, multiplier: 1/2.5).isActive = true
            
            let nameLabel = UILabel()
            nameLabel.textAlignment = .center
            nameLabel.text = "Add Kick"
            nameLabel.textColor = UIColor.white
            nameLabel.translatesAutoresizingMaskIntoConstraints = false
            cell.addSubview(nameLabel)
            nameLabel.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: -5).isActive = true
            nameLabel.centerXAnchor.constraint(equalTo: cell.centerXAnchor).isActive = true
            nameLabel.widthAnchor.constraint(equalTo: cell.widthAnchor, multiplier: 1/1.25).isActive = true
            nameLabel.heightAnchor.constraint(equalTo: cell.heightAnchor, multiplier: 1/5).isActive = true
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

