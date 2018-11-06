//
//  HomeTableViewCell.swift
//  Zaha
//
//  Created by Faraz Haider on 30/10/2018.
//  Copyright © 2018 Faraz Haider. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var experienceBackgroundImageView: UIImageView!
    @IBOutlet weak var experienceVideoIconImageView: UIImageView!
    @IBOutlet weak var experienceTitleLabel: UILabel!
    @IBOutlet weak var experiencePriceLabel: UILabel!
    @IBOutlet weak var experienceDateTimeLabel: UILabel!
    @IBOutlet weak var experienceUserLabel: UILabel!
    @IBOutlet weak var experienceCategoryLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
