//
//  MapTableViewCell.swift
//  codeChallenge
//
//  Created by Simeng Liu on 10/12/17.
//  Copyright © 2017 Simeng Liu. All rights reserved.
//

import UIKit
import MapKit

class MapTableViewCell: UITableViewCell {

    @IBOutlet var myMKMapView: MKMapView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
