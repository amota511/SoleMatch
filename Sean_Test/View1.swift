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
    
    var rightButton: UIButton!
    var userImage: UIImageView!
    var userName: UILabel!
    var collectionButton: UILabel!
    var myCollection: UICollectionView!
    var preferencesButton: UILabel!
    var myPreferences: UIView!
    var myPrefSize: UILabel!
    var myPrefSliderValue: Float!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createRightButton()
        createUserImage()
        createUserNameLabel()
        createCollectionButton()
        //createMyCollectionView()
        createPreferencesButton()
        createPreferencesView()
    }
    
    func  createRightButton() {
        
        let rightButton = UIButton()
        rightButton.setTitle("Right", for: .normal)
        rightButton.setTitleColor(UIColor.blue, for: .normal)
        rightButton.addTarget(self, action: #selector(scrollRight), for: .touchUpInside)

        self.view.addSubview(rightButton)
        
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        rightButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 24).isActive = true
        rightButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12).isActive = true
        rightButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/8).isActive = true
        rightButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/15).isActive = true
        
        
        self.rightButton = rightButton
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
        userImage.layer.cornerRadius = 47.5
        
        
        self.view.addSubview(userImage)
        
        userImage.topAnchor.constraint(equalTo: rightButton.bottomAnchor, constant: 15).isActive = true
        userImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        userImage.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1/4).isActive = true
        userImage.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/8).isActive = true
        
        self.userImage = userImage
    }
    
    func createUserNameLabel() {
        
        let userNameLabel = UILabel()
        userNameLabel.text = "Drizzy Drake"
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
        print("Collection button was tapped")
    }
    
    func createMyCollectionView() {
        let connectionsLayout = UICollectionViewFlowLayout()
        connectionsLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        connectionsLayout.scrollDirection = .vertical
        
        
        
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
        connectionsCollectionView.alwaysBounceHorizontal = false
        connectionsCollectionView.allowsMultipleSelection = false
        connectionsCollectionView.alwaysBounceVertical = true
        connectionsCollectionView.bounces = true
        
        self.view.addSubview(connectionsCollectionView)
        
        connectionsCollectionView.topAnchor.constraint(equalTo: collectionButton.bottomAnchor).isActive = true
        connectionsCollectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        connectionsCollectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        connectionsCollectionView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/3).isActive = true
        
        self.myCollection = connectionsCollectionView
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
        
        preferencesButton.topAnchor.constraint(equalTo: collectionButton.bottomAnchor, constant: 1).isActive = true
        preferencesButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        preferencesButton.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        preferencesButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/18).isActive = true
        
        self.preferencesButton = preferencesButton
    }
    
    func myPreferencesTapRecognizer(){
        print("Preferences button was tapped")
    }
    
    func createPreferencesView() {
        
        let preferencesView = UIView()
        preferencesView.backgroundColor = UIColor.white
        preferencesView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(preferencesView)
        
        preferencesView.topAnchor.constraint(equalTo: preferencesButton.bottomAnchor, constant: 1).isActive = true
        preferencesView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        preferencesView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        preferencesView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/3).isActive = true
        
        
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
        
        sizeSlider.setValue(7, animated: true)
        self.myPrefSliderValue = sizeSlider.value
        sizeSlider.maximumTrackTintColor = UIColor.green
        sizeSlider.tintColor = UIColor.blue
        
        sizeLabel.text = "Size: \(sizeSlider.value)"
        
        sizeSlider.addTarget(self, action: #selector(sliderMoved(sender:)), for: .valueChanged)
        
        preferencesView.addSubview(sizeSlider)
        
        sizeSlider.topAnchor.constraint(equalTo: sizeLabel.bottomAnchor, constant: 2).isActive = true
        sizeSlider.centerXAnchor.constraint(equalTo: preferencesView.centerXAnchor).isActive = true
        sizeSlider.widthAnchor.constraint(equalTo: preferencesView.widthAnchor).isActive = true
        sizeSlider.heightAnchor.constraint(equalTo: preferencesView.heightAnchor, multiplier: 1/6).isActive = true
        
        
        
        
    }
    
    func sliderMoved(sender: UISlider) {
        if sender.value > myPrefSliderValue {
            sender.setValue( floorf(sender.value), animated: false)
        }else{
            sender.setValue( floorf(sender.value), animated: false)
        }
        
        myPrefSliderValue = sender.value
        print(sender.value)
        myPrefSize.text = "Size: \(sender.value)"
    }

    func scrollRight(){
        let v2Frame : CGRect = CGRect(x: Int((self.view.frame.width) * 1.67), y: 0, width: Int(scrollView.frame.width / 3), height: Int(scrollView.frame.height))
        self.scrollView.scrollRectToVisible(v2Frame, animated: true)
        print("The right button was excecuted")
    }

    override func viewDidAppear(_ animated: Bool) {
        self.scrollView = self.view.superview as! UIScrollView
    }
    
}

extension View1: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 36
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

