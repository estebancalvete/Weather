//
//  ForecastTableViewCell.swift
//  Weather
//
//  Created by Esteban Calvete Iglesias on 22/04/2021.
//

import UIKit

class ForecastTableViewCell: UITableViewCell{
    @IBOutlet weak var dayOfWeekLable: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var tempLable: UILabel!
    
    func configure (data: DailyWeather) {
        
        tempLable.text = String(format: "%.0f", data.temp.day) + " ºC"
        weatherImage.image = UIImage(named: data.weather.first?.icon ?? "01d")
        let time = Date(timeIntervalSince1970: data.dt)
        dayOfWeekLable.text = dayOfWeek(date: time)
    }
    
    private func dayOfWeek(date: Date) -> String {
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "EEEE"
        return dayFormatter.string(from: date).capitalized
    }
}
