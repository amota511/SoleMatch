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
    }


    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reviewsCell", for: indexPath) as! ReviewsCell

        

        return cell
    }
    
    

}
