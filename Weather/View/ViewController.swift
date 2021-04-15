//
//  ViewController.swift
//  Weather
//
//  Created by Esteban Calvete Iglesias on 14/04/2021.
//

import UIKit

class ViewController: UIViewController {

    //MARK: Variables
    
    
    
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
        
        
        
        
        
        networkService.shared.getWeather()
    }

    //MARK: Functions

}

