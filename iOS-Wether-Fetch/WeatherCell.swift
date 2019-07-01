//
//  WeatherCell.swift
//  iOS-Wether-Fetch
//
//  Created by BOTTAK on 6/29/19.
//  Copyright © 2019 BOTTAK. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {
    
    //MARK: - Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    
    //MARK:

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
