//
//  ForecastTableViewCell.swift
//  Weather
//
//  Created by Esteban Calvete Iglesias on 22/04/2021.
//

import UIKit

class ForecastTableViewCell: UITableViewCell{
    @IBOutlet weak var dayOfWeekLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    
    func configure (data: DailyWeather) {
        
        maxTempLabel.text = String(format: "%.0f", data.temp.max) + " ºC"
        minTempLabel.text = String(format: "%.0f", data.temp.min) + " ºC"
        weatherImageView.image = UIImage(named: data.weather.first?.icon ?? "01d")
        let time = Date(timeIntervalSince1970: data.dt)
        dayOfWeekLabel.text = dayOfWeek(date: time)
    }
    
    private func dayOfWeek(date: Date) -> String {
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "EEEE"
        return dayFormatter.string(from: date).capitalized
    }
}
