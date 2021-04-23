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
        var cal = Calendar(identifier: .gregorian)
        cal.timeZone = TimeZone(identifier: "Europe/Berlin") ?? .current
        let weekDay = cal.component(.weekday, from: time) % 7
        let dayString = Calendar.current.weekdaySymbols[weekDay]
        dayOfWeekLable.text = dayString
        
        dayOfWeekLable.text = time.dayOfWeek()
        
        dayOfWeekLable.text = dayOfWeek(date: time)
    }
    
    private func dayOfWeek(date: Date) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date).capitalized
    }
}
