

//
//  ForecastTableViewCell.swift
//  SimpleWeather
//
//  Created by George Lyurko on 27.07.2018.
//  Copyright © 2018 George Lyurko. All rights reserved.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {
    @IBOutlet weak var ForecastImage: UIImageView!
    @IBOutlet weak var AvgTempTitleLabel: UILabel!
    @IBOutlet weak var PrecipTitleLabel: UILabel!
    @IBOutlet weak var AvgTempLabel: UILabel!
    @IBOutlet weak var PrecipLabel: UILabel!
    @IBOutlet weak var ForecastTextDescription: UILabel!
    @IBOutlet weak var ForecastDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        AvgTempTitleLabel.text = LocalizeApp.averageTemp.instance
        PrecipTitleLabel.text = LocalizeApp.precipitation.instance
    }

   

}
