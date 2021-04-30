//
//  ForecastTableViewCell.swift
//  Weather
//
//  Created by Esteban Calvete Iglesias on 22/04/2021.
//

import UIKit

class ForecastTableViewCell: UITableViewCell{
    @IBOutlet weak var dayOfWeekLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    
    func configure (data: DailyWeather) {
        
        tempLabel.text = String(format: "%.0f", data.temp.day) + " ºC"
        weatherImage.image = UIImage(named: data.weather.first?.icon ?? "01d")
        let time = Date(timeIntervalSince1970: data.dt)
        dayOfWeekLabel.text = dayOfWeek(date: time)
    }
    
    private func dayOfWeek(date: Date) -> String {
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "EEEE"
        return dayFormatter.string(from: date).capitalized
    }
}
