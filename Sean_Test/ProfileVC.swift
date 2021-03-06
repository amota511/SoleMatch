//
//  View1.swift
//  Sean_Test
//
//  Created by amota511 on 1/21/17.
//  Copyright © 2017 Aaron Motayne. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

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
    var reviewsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createUserImage()
        createUserNameLabel()
        createCollectionButton()
        createMyCollectionView()
        createPreferencesButton()
        createPreferencesView()
        createReviewsLabel()
        createReviewsTBVC()

        imageArray.append(#imageLiteral(resourceName: "Air Mag"))
        imageArray.append(#imageLiteral(resourceName: "Yeezy Red Stripe"))
        imageArray.append(#imageLiteral(resourceName: "Yeezy Orange Stripe"))
        imageArray.append(#imageLiteral(resourceName: "OvO 10"))
        imageArray.append(#imageLiteral(resourceName: "Concord 11"))

    }
    
    func createReviewsTBVC() {
        let reviewsTBVC = ReviewsTBVC()
        //reviewsTBVC.view.frame = CGRect(x: 0, y: 400, width: self.view.frame.width, height: self.view.frame.height / 3)
        reviewsTBVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        self.addChildViewController(reviewsTBVC)
        self.view.addSubview(reviewsTBVC.view)
        
        reviewsTBVC.view.topAnchor.constraint(equalTo: self.reviewsLabel.bottomAnchor, constant: 5).isActive = true
        reviewsTBVC.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        reviewsTBVC.view.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1).isActive = true
        reviewsTBVC.view.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        
        
    }
    
    func createReviewsLabel() {
        let reviewsLabel = UILabel()
        reviewsLabel.text = "My Reviews"
        reviewsLabel.textAlignment = .center
        reviewsLabel.textColor = UIColor.black
        reviewsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        self.reviewsLabel = reviewsLabel
        self.view.addSubview(self.reviewsLabel)
        reviewsLabel.topAnchor.constraint(equalTo: self.myPreferences.bottomAnchor, constant: 5).isActive = true
        reviewsLabel.centerXAnchor.constraint(equalTo: self.myPreferences.centerXAnchor).isActive = true
        reviewsLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1/2).isActive = true
        reviewsLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/15).isActive = true
        
    }
    
    func createUserImage() {
        
        
        //let url = URL(string: "https://thefader-res.cloudinary.com/images/w_2400,c_limit,f_auto,q_auto:best/F100_Drake_Cover_FINAL_tuqta0/drake-views-from-the-6-cover-story-interview.jpg")
        
        let userImage = UIImageView(image: #imageLiteral(resourceName: "kanye-west"))
        
//        do {
//            
//            let data = try Data(contentsOf: url!)
//            
//            let userPhoto = UIImage(data: data)
//            userImage.image = userPhoto
//            
//        }catch {
//            
//        }
        userImage.contentMode = .scaleAspectFill
        userImage.translatesAutoresizingMaskIntoConstraints = false
        userImage.clipsToBounds = true
        
        let editUserImageGestureRecognizer = UIGestureRecognizer(target: self, action: #selector(editUserImage))
        userImage.addGestureRecognizer(editUserImageGestureRecognizer)
        
        userImage.layer.borderWidth = 3.0
        userImage.layer.borderColor = UIColor.white.cgColor
        
        self.view.addSubview(userImage)
        
        userImage.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20).isActive = true
        userImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        userImage.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1/3).isActive = true
        userImage.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1/3).isActive = true
        
        userImage.layer.cornerRadius = (self.view.frame.width / 6)
        
        self.userImage = userImage
        
        createStars()
        
    }
    
    func editUserImage() {
        print("user image tapped")
        let photoSelectionAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        photoSelectionAlertController.addAction(UIAlertAction(title: "Import From Camera Roll", style: .default, handler: { (UIAlertAction) in
            
            
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                
                
                let picker = UIImagePickerController()
                picker.delegate = self
                picker.sourceType = .photoLibrary
                picker.allowsEditing = false
                self.present(picker, animated: true, completion: nil)
                
            }else {
                print("The camera roll is not available")
            }
        }))
        
        
        photoSelectionAlertController.addAction(UIAlertAction(title: "Use Camera", style: .default, handler: { (UIAlertAction) in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                
                
                let picker = UIImagePickerController()
                picker.delegate = self
                picker.sourceType = .camera
                picker.allowsEditing = false
                self.present(picker, animated: true, completion: nil)
                
            }else {
                print("The camera is not available")
            }
        }))
        
        
        photoSelectionAlertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (UIAlertAction) in
            photoSelectionAlertController.dismiss(animated: true)
        }))
        
        self.present(photoSelectionAlertController, animated: true)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        self.userImage.image = image
        print("Image picked")
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print(info)
        
        self.userImage.image = info[UIImagePickerControllerOriginalImage] as! UIImage?
        picker.dismiss(animated: true) {
            
        }
    }
    
    func createStars() {
        let thirdStar = UIImageView(image: #imageLiteral(resourceName: "Gold_Star"))
        thirdStar.contentMode = .scaleAspectFit
        thirdStar.transform = thirdStar.transform.rotated(by: 0.0)
        thirdStar.translatesAutoresizingMaskIntoConstraints = false
        thirdStar.backgroundColor = UIColor.clear
        self.view.addSubview(thirdStar)
        thirdStar.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 0).isActive = true
        thirdStar.centerXAnchor.constraint(equalTo: userImage.centerXAnchor, constant: 0).isActive = true
        thirdStar.widthAnchor.constraint(equalTo: userImage.widthAnchor, multiplier: 1/4).isActive = true
        thirdStar.heightAnchor.constraint(equalTo: userImage.heightAnchor, multiplier: 1/4).isActive = true
        
        let secondStar = UIImageView(image: #imageLiteral(resourceName: "Gold_Star"))
        secondStar.contentMode = .scaleAspectFit
        secondStar.transform = secondStar.transform.rotated(by: 0.5)
        secondStar.translatesAutoresizingMaskIntoConstraints = false
        secondStar.backgroundColor = UIColor.clear
        self.view.addSubview(secondStar)
        secondStar.topAnchor.constraint(equalTo: thirdStar.topAnchor, constant: -7).isActive = true
        secondStar.centerXAnchor.constraint(equalTo: thirdStar.centerXAnchor, constant: (-(self.view.frame.width / 12) - 5)).isActive = true
        secondStar.widthAnchor.constraint(equalTo: thirdStar.widthAnchor).isActive = true
        secondStar.heightAnchor.constraint(equalTo: thirdStar.heightAnchor).isActive = true
        
        let fourthStar = UIImageView(image: #imageLiteral(resourceName: "Gold_Star"))
        fourthStar.contentMode = .scaleAspectFit
        fourthStar.transform = fourthStar.transform.rotated(by: -0.5)
        fourthStar.translatesAutoresizingMaskIntoConstraints = false
        fourthStar.backgroundColor = UIColor.clear
        self.view.addSubview(fourthStar)
        fourthStar.topAnchor.constraint(equalTo: thirdStar.topAnchor, constant: -7).isActive = true
        fourthStar.centerXAnchor.constraint(equalTo: thirdStar.centerXAnchor, constant: (self.view.frame.width / 12) + 5).isActive = true
        fourthStar.widthAnchor.constraint(equalTo: thirdStar.widthAnchor).isActive = true
        fourthStar.heightAnchor.constraint(equalTo: thirdStar.heightAnchor).isActive = true
        
        let firstStar = UIImageView(image: #imageLiteral(resourceName: "Gold_Star"))
        firstStar.contentMode = .scaleAspectFit
        firstStar.transform = firstStar.transform.rotated(by: -0.42)
        firstStar.translatesAutoresizingMaskIntoConstraints = false
        firstStar.backgroundColor = UIColor.clear
        self.view.addSubview(firstStar)
        firstStar.topAnchor.constraint(equalTo: secondStar.topAnchor, constant: -25).isActive = true
        firstStar.centerXAnchor.constraint(equalTo: secondStar.centerXAnchor, constant: -(self.view.frame.width / 12) + 2.5).isActive = true
        firstStar.widthAnchor.constraint(equalTo: secondStar.widthAnchor).isActive = true
        firstStar.heightAnchor.constraint(equalTo: secondStar.heightAnchor).isActive = true
        
        let fifthStar = UIImageView(image: #imageLiteral(resourceName: "Gold_Star"))
        fifthStar.contentMode = .scaleAspectFit
        fifthStar.transform = fifthStar.transform.rotated(by: 0.42)
        fifthStar.translatesAutoresizingMaskIntoConstraints = false
        fifthStar.backgroundColor = UIColor.clear
        self.view.addSubview(fifthStar)
        fifthStar.topAnchor.constraint(equalTo: fourthStar.topAnchor, constant: -25).isActive = true
        fifthStar.centerXAnchor.constraint(equalTo: fourthStar.centerXAnchor, constant: (self.view.frame.width / 12) - 2.5).isActive = true
        fifthStar.widthAnchor.constraint(equalTo: fourthStar.widthAnchor).isActive = true
        fifthStar.heightAnchor.constraint(equalTo: fourthStar.heightAnchor).isActive = true
    }
    
    func createUserNameLabel() {
        
        let userNameLabel = UILabel()
        userNameLabel.text = "Kanye West"
        userNameLabel.textAlignment = .center
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(userNameLabel)
        
        userNameLabel.topAnchor.constraint(equalTo: self.userImage.bottomAnchor, constant: 25).isActive = true
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
        //self.myCollectionHeight.isActive = false
        if !isMyCollectionDroppedDown {
            self.myCollectionHeight.constant.add(self.view.frame.height * (1/2.35))
            
                //.subtract(self.myCollectionHeight.multiplier)
            //self.myCollectionHeight = myCollection.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/2.35)
            isMyCollectionDroppedDown = !isMyCollectionDroppedDown
        }else{
            self.myCollectionHeight.constant.subtract(self.view.frame.height * (1/2.35))
            //self.myCollectionHeight.multiplier.add(self.myCollectionHeight.multiplier)
            //= 1/2.35
            //self.myCollectionHeight = myCollection.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0)
//            UIView.animate(withDuration: 1.5, delay: 0.0, usingSpringWithDamping: 0.80, initialSpringVelocity: 0.0, options: [], animations: {
//                self.view.layoutIfNeeded()
//            }, completion: nil)
            isMyCollectionDroppedDown = !isMyCollectionDroppedDown
        }
        
        UIView.animate(withDuration: 1.5, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: [.curveEaseOut], animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)

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
//        preferencesButton.layer.borderColor = UIColor(red: 215/255.0, green: 215/255.0, blue: 215/255.0, alpha: 1.0).cgColor
//        preferencesButton.layer.borderWidth = 1
        
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

//    func scrollRight(){
//        let v2Frame : CGRect = CGRect(x: Int((self.view.frame.width) * 1.67), y: 0, width: Int(scrollView.frame.width / 3), height: Int(scrollView.frame.height))
//        scrollView.scrollRectToVisible(v2Frame, animated: true)
//        print("The right button was excecuted")
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        self.scrollView = self.view.superview as! UIScrollView
//    }
    
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 6
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ConnectionsCell", for: indexPath)
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 20
        
        if indexPath.row == imageArray.count {
            
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
            nameLabel.text = "Add Sneaker"
            nameLabel.textColor = UIColor.white
            nameLabel.adjustsFontSizeToFitWidth = true
            nameLabel.translatesAutoresizingMaskIntoConstraints = false
            cell.addSubview(nameLabel)
            nameLabel.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: -5).isActive = true
            nameLabel.centerXAnchor.constraint(equalTo: cell.centerXAnchor).isActive = true
            nameLabel.widthAnchor.constraint(equalTo: cell.widthAnchor, multiplier: 1).isActive = true
            nameLabel.heightAnchor.constraint(equalTo: cell.heightAnchor, multiplier: 1/5).isActive = true
        }else if indexPath.row < imageArray.count {
            let imageView = UIImageView()
            imageView.image = imageArray[indexPath.row]
            imageView.contentMode = .scaleAspectFill
            imageView.translatesAutoresizingMaskIntoConstraints = false
            cell.addSubview(imageView)
            imageView.topAnchor.constraint(equalTo: cell.topAnchor).isActive = true
            imageView.leftAnchor.constraint(equalTo: cell.leftAnchor).isActive = true
            imageView.heightAnchor.constraint(equalTo: cell.heightAnchor).isActive = true
            imageView.widthAnchor.constraint(equalTo: cell.widthAnchor).isActive = true
        
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let baseView = self.parent as! BaseVC
        baseView.showAddSneakerViewController()

    
    }
}

