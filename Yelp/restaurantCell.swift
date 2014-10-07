//
//  restaurantCell.swift
//  Yelp
//
//  Created by Bhagchandani, Deepak on 10/4/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

import UIKit

class restaurantCell: UITableViewCell {

    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var bizTitle: UILabel!
    
    @IBOutlet weak var bizReviewImage: UIImageView!
    @IBOutlet weak var bizRating: UIImageView!
    @IBOutlet weak var bizReview: UILabel!
    @IBOutlet weak var bizAddress: UILabel!
    @IBOutlet weak var bizCategories: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

    
}
