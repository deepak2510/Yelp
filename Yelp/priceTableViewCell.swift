//
//  priceTableViewCell.swift
//  Yelp
//
//  Created by Bhagchandani, Deepak on 10/5/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

import UIKit

class priceTableViewCell: UITableViewCell {

    var selectedPriceIndex : Int? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func selectedPrice(sender: UISegmentedControl) {
        self.selectedPriceIndex = sender.selectedSegmentIndex
    }
}
