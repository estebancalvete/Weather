//
//  DailyWeatherTableViewCell.swift
//  Weather
//
//  Created by Martín Calvete Iglesias on 20/4/21.
//

import UIKit

class DailyWeatherTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dayOfWeekLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    
    func configugre(data: DailyWeather) {
        dayOfWeekLabel.text = data.weather.first?.description
        weatherIcon.image = UIImage(named: "01d")
        tempLabel.text = String(format: "%.1f", data.temp.max)
    }
}
