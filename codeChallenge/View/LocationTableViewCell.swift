//
//  LocationTableViewCell.swift
//  codeChallenge
//
//  Created by Simeng Liu on 8/12/17.
//  Copyright © 2017 Simeng Liu. All rights reserved.
//

import UIKit

class LocationTableViewCell: UITableViewCell {

    @IBOutlet weak var locationNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        locationNameLabel.layer.borderWidth = 1
        locationNameLabel.layer.masksToBounds = false
        locationNameLabel.layer.borderColor = UIColor.white.cgColor
        locationNameLabel.layer.cornerRadius = 10
        locationNameLabel.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
