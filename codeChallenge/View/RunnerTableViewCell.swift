//
//  RunnerTableViewCell.swift
//  codeChallenge
//
//  Created by Simeng Liu on 10/12/17.
//  Copyright © 2017 Simeng Liu. All rights reserved.
//

import UIKit

class RunnerTableViewCell: UITableViewCell {
    @IBOutlet weak var runnerImageView: UIImageView!
    
    @IBOutlet weak var desLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        
        
        super.awakeFromNib()
        
        runnerImageView.layer.borderWidth = 1
        runnerImageView.layer.masksToBounds = false
        runnerImageView.layer.borderColor = UIColor.white.cgColor
        runnerImageView.layer.cornerRadius = runnerImageView.frame.height/2
        runnerImageView.clipsToBounds = true
        
        
        
       
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
