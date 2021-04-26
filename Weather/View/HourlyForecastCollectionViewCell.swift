//
//  HourlyForecastCollectionViewCell.swift
//  Weather
//
//  Created by Martín Calvete Iglesias on 26/4/21.
//

import UIKit

class HourlyForecastCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var hourOfDayLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    
    func configure (data: HourlyWeather) {
        tempLabel.text = String(format: "%.0f", data.temp) + " ºC"
        weatherImage.image = UIImage(named: data.weather.first?.icon ?? "01d")
        let time = Date(timeIntervalSince1970: data.dt)
        hourOfDayLabel.text = dayOfWeek(date: time)
    }
    
    private func dayOfWeek(date: Date) -> String {
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "EEEE"
        return dayFormatter.string(from: date).capitalized
    }
}
