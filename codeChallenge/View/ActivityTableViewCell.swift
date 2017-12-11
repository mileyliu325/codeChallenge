//
//  ActivityTableViewCell.swift
//  codeChallenge
//
//  Created by Simeng Liu on 10/12/17.
//  Copyright © 2017 Simeng Liu. All rights reserved.
//

import UIKit

class ActivityTableViewCell: UITableViewCell {

    @IBOutlet weak var activityImageView: UIImageView!
    @IBOutlet weak var actDesLabel: UILabel!
    @IBOutlet weak var actTypeLabel: UILabel!
  
    override func awakeFromNib() {
        
        super.awakeFromNib()
        activityImageView.layer.borderWidth = 1
        activityImageView.layer.masksToBounds = false
        activityImageView.layer.borderColor = UIColor.white.cgColor
        activityImageView.layer.cornerRadius = activityImageView.frame.height/2
        activityImageView.clipsToBounds = true
        
        
        
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
