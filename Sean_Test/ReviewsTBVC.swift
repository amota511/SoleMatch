//
//  ReviewsTBVC.swift
//  SoleMatch
//
//  Created by amota511 on 3/25/17.
//  Copyright © 2017 Aaron Motayne. All rights reserved.
//

import UIKit

class ReviewsTBVC: UITableViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.tableView.register(ReviewsCell.self, forCellReuseIdentifier: "reviewsCell")
        self.tableView.allowsSelection = false
        
    }


    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reviewsCell", for: indexPath) as! ReviewsCell
        let name = "Jay-Z"
        //let location = "New York, NY"
        cell.nameLabel.text = name + ": " //+ ", " + location
        cell.nameLabel.font = cell.nameLabel.font.withSize(18)
        cell.contentView.addSubview(cell.nameLabel)
        
        cell.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        cell.nameLabel.leftAnchor.constraint(equalTo: cell.leftAnchor, constant: 6).isActive = true
        
        cell.nameLabel.topAnchor.constraint(equalTo: cell.topAnchor, constant: 8).isActive = true
        cell.nameLabel.widthAnchor.constraint(equalTo: cell.widthAnchor, multiplier: 1/2).isActive = true
        cell.nameLabel.heightAnchor.constraint(equalTo: cell.heightAnchor, multiplier: 1/5).isActive = true
        
        
        
        cell.contentView.addSubview(cell.starsContainer)
        
        cell.starsContainer.translatesAutoresizingMaskIntoConstraints = false
        
        cell.starsContainer.topAnchor.constraint(equalTo: cell.topAnchor, constant: 5).isActive = true
        cell.starsContainer.widthAnchor.constraint(equalTo: cell.widthAnchor, multiplier: 1/3.5).isActive = true
        cell.starsContainer.heightAnchor.constraint(equalTo: cell.heightAnchor, multiplier: 1/5.5).isActive = true
        cell.starsContainer.rightAnchor.constraint(equalTo: cell.rightAnchor, constant: -5).isActive = true
        
        createStars(starContainer: cell.starsContainer, cell: cell)
        createReviewTextView(starContainer: cell.starsContainer, cell: cell)
        
        let review = cell.review
        review.text = "I miss the old Kanye, straight from the Go Kanye. Chop up the soul Kanye, set on his goals Kanye. I hate the new Kanye, the bad mood Kanye. The always rude Kanye, spaz in the news Kanye. I miss the sweet Kanye, chop up the beats Kanye."
        
        return cell
    }
    
    func createStars(starContainer: UIView, cell: ReviewsCell){
        
        let star1 = cell.star1
        let star2 = cell.star2
        let star3 = cell.star3
        let star4 = cell.star4
        let star5 = cell.star5
        
        star1.image = #imageLiteral(resourceName: "Gold_Star")
        star2.image = #imageLiteral(resourceName: "Gold_Star")
        star3.image = #imageLiteral(resourceName: "Gold_Star")
        star4.image = #imageLiteral(resourceName: "Gold_Star")
        star5.image = #imageLiteral(resourceName: "Gold_Star")
        
        star1.translatesAutoresizingMaskIntoConstraints = false
        star2.translatesAutoresizingMaskIntoConstraints = false
        star3.translatesAutoresizingMaskIntoConstraints = false
        star4.translatesAutoresizingMaskIntoConstraints = false
        star5.translatesAutoresizingMaskIntoConstraints = false
        
        starContainer.addSubview(star1)
        starContainer.addSubview(star2)
        starContainer.addSubview(star3)
        starContainer.addSubview(star4)
        starContainer.addSubview(star5)
        
        star1.leftAnchor.constraint(equalTo: starContainer.leftAnchor).isActive = true
        star1.topAnchor.constraint(equalTo: starContainer.topAnchor).isActive = true
        star1.bottomAnchor.constraint(equalTo: starContainer.bottomAnchor).isActive = true
        star1.widthAnchor.constraint(equalTo: starContainer.widthAnchor, multiplier: 1/4.9).isActive = true
        
       
        star2.leftAnchor.constraint(equalTo: star1.rightAnchor).isActive = true
        star2.topAnchor.constraint(equalTo: starContainer.topAnchor).isActive = true
        star2.bottomAnchor.constraint(equalTo: starContainer.bottomAnchor).isActive = true
        star2.widthAnchor.constraint(equalTo: starContainer.widthAnchor, multiplier: 1/4.9).isActive = true
        
        star3.leftAnchor.constraint(equalTo: star2.rightAnchor).isActive = true
        star3.topAnchor.constraint(equalTo: starContainer.topAnchor).isActive = true
        star3.bottomAnchor.constraint(equalTo: starContainer.bottomAnchor).isActive = true
        star3.widthAnchor.constraint(equalTo: starContainer.widthAnchor, multiplier: 1/4.9).isActive = true
        
        star4.leftAnchor.constraint(equalTo: star3.rightAnchor).isActive = true
        star4.topAnchor.constraint(equalTo: starContainer.topAnchor).isActive = true
        star4.bottomAnchor.constraint(equalTo: starContainer.bottomAnchor).isActive = true
        star4.widthAnchor.constraint(equalTo: starContainer.widthAnchor, multiplier: 1/4.9).isActive = true
        
        star5.leftAnchor.constraint(equalTo: star4.rightAnchor).isActive = true
        star5.topAnchor.constraint(equalTo: starContainer.topAnchor).isActive = true
        star5.bottomAnchor.constraint(equalTo: starContainer.bottomAnchor).isActive = true
        star5.widthAnchor.constraint(equalTo: starContainer.widthAnchor, multiplier: 1/4.9).isActive = true
    }
    
    func createReviewTextView(starContainer: UIView, cell: ReviewsCell){
        
        let review = cell.review
        
        review.translatesAutoresizingMaskIntoConstraints = false
        review.isEditable = false
        review.isUserInteractionEnabled = false
        
        cell.contentView.addSubview(review)
        
        review.leftAnchor.constraint(equalTo: cell.leftAnchor, constant: 15).isActive = true
        review.rightAnchor.constraint(equalTo: cell.rightAnchor, constant: -5).isActive = true
        review.topAnchor.constraint(equalTo: starContainer.bottomAnchor, constant: 3).isActive = true
        review.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: -3).isActive = true
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.height / 2
    }
    

}
