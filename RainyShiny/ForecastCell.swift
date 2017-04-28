//
//  ForecastCell.swift
//  RainyShiny
//
//  Created by Tianchong Xie on 2017-04-27.
//  Copyright © 2017 Tianchong Xie. All rights reserved.
//

import UIKit

class ForecastCell: UITableViewCell {

    @IBOutlet weak var forecastImg: UIImageView!
    @IBOutlet weak var forecastDate: UILabel!
    @IBOutlet weak var forecastWeatherType: UILabel!
    @IBOutlet weak var forecastMax: UILabel!
    @IBOutlet weak var forecastMin: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateUI(forecast: Forecast){
       forecastDate.text = forecast.date
       forecastWeatherType.text = forecast.weatherType
       forecastMax.text = String(forecast.highTemp)
       forecastMin.text = String(forecast.lowTemp)
       forecastImg.image = UIImage(named: forecast.weatherType)
    }
    

}
