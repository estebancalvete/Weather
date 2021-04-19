//
//  ViewController.swift
//  Weather
//
//  Created by Esteban Calvete Iglesias on 14/04/2021.
//

import UIKit

class ViewController: UIViewController {

    //MARK: Variables
    
    var cityName: String = "Berlin"
    
    
    //MARK: Constants
    
    
    
    
    
    //MARK: IBOutlets
    
    @IBOutlet weak var cityNameLable: UILabel!
    @IBOutlet weak var weatherTitleLable: UILabel!

    @IBOutlet weak var weekDay1Lable: UILabel!
    @IBOutlet weak var weekDay2Lable: UILabel!
    @IBOutlet weak var weekDay3Lable: UILabel!
    @IBOutlet weak var weekDay4Lable: UILabel!
    @IBOutlet weak var weekDay5Lable: UILabel!
    @IBOutlet weak var weekDay6Lable: UILabel!
    
    // Temperature Lables
    
    @IBOutlet weak var currentTempLable: UILabel!
    @IBOutlet weak var day1TempLable: UILabel!
    @IBOutlet weak var day2TempLable: UILabel!
    @IBOutlet weak var day3TempLable: UILabel!
    @IBOutlet weak var day4TempLable: UILabel!
    @IBOutlet weak var day5TempLable: UILabel!
    @IBOutlet weak var day6TempLable: UILabel!
    
    
    // Weather Images
    
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var day1WeatherImage: UIImageView!
    @IBOutlet weak var day2WeatherImage: UIImageView!
    @IBOutlet weak var day3WeatherImage: UIImageView!
    @IBOutlet weak var day4WeatherImage: UIImageView!
    @IBOutlet weak var day5WeatherImage: UIImageView!
    @IBOutlet weak var day6WeatherImage: UIImageView!
    
    
    
    //MARK: Live Cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityNameLable.text = cityName
        
        NetworkService.shared.getWeather { (response) in
            self.currentTempLable.text = String(format: "%.1f", response?.current.temp ?? "T ºC")
            let description: String = response?.current.weather[0].description ?? "Description"
            self.weatherTitleLable.text = description
            var imageString: String = "cloud"
            switch description {
            case "clear sky":
                imageString = "sun.max"
            case "few clouds":
                imageString = "cloud.sun"
            case "scattered clouds":
                imageString = "cloud"
            case "broken clouds":
                imageString = "cloud.fill"
            case "shower rain":
                imageString = "cloud.heavyrain"
            case "rain":
                imageString = "cloud.rain"
            case "thunderstorm":
                imageString = "cloud.bolt"
            case "snow":
                imageString = "snow"
            case "mist":
                imageString = "cloud.fog"
            default:
                imageString = "moon.stars"
            }
            self.currentWeatherImage.image = UIImage(systemName: imageString)
            
//            let iconCode: String = response?.current.weather[0].icon ?? ""
//            switch iconCode {
//            case: "01d"
//                self.currentWeatherImage.image = UIImage(systemName: "cloud.rain.fill")
//            case: "02d"
//                self.currentWeatherImage.image = UIImage(systemName: "cloud.rain.fill")
//            default:
//                self.currentWeatherImage.image = UIImage(systemName: "moon.stars")
//            }
        }
    }

    //MARK: Functions

}

