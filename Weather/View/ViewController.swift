//
//  ViewController.swift
//  Weather
//
//  Created by Esteban Calvete Iglesias on 14/04/2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    

    //MARK: Variables
    
    var cityName: String = "Berlin"
    var apiResponse: OneCallResponse? = nil
    
    
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
    
    @IBOutlet weak var weekForecastTableView: UITableView!
    
    //MARK: Live Cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Configure tableview
        weekForecastTableView.dataSource = self
        
        cityNameLable.text = cityName
        
        NetworkService.shared.getWeather { (response) in
            self.apiResponse = response
            
            self.weekForecastTableView.reloadData()
            
            
            self.currentTempLable.text = String(format: "%.1f", response?.current.temp ?? "T ºC")
            let description: String = response?.current.weather[0].description ?? "Description"
            self.weatherTitleLable.text = description
            
            if let iconName = response?.current.weather[0].icon {
//                self.currentWeatherImage.image = UIImage(named: iconName)
                self.currentWeatherImage.image = UIImage(named: "01d")
            }
            
        }
    }

    //MARK: Functions

    
    //MARK: UITableViewDataSource methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apiResponse?.daily.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DailyWeatherTableViewCell",
                                                 for: indexPath) as! DailyWeatherTableViewCell
        if let apiResponse = apiResponse {
            cell.configugre(data: apiResponse.daily[indexPath.row])
        }

        return cell
    }
}

