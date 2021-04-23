//
//  ViewController.swift
//  Weather
//
//  Created by Esteban Calvete Iglesias on 14/04/2021.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, UITableViewDataSource, CLLocationManagerDelegate {

    //MARK: Variables
    
    var apiResponse: OneCallResponse? = nil
    
    //MARK: Constants
    
    let cityName = "Berlin"
    let locationManager = CLLocationManager()
    
    
    //MARK: IBOutlets
    
    @IBOutlet weak var cityNameLable: UILabel!
    @IBOutlet weak var weatherTitleLable: UILabel!
    @IBOutlet weak var currentTempLable: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var forecastWeatherTable: UITableView!
    
    //MARK: Live Cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLocation()
        
        cityNameLable.text = cityName
        
        forecastWeatherTable.dataSource = self
    }

    //MARK: Functions
    
    private func configureLocation() {
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    private func getWeatherAndUpdateView() {
        NetworkService.shared.getWeather { (response) in
            
            self.apiResponse = response
            
            self.forecastWeatherTable.reloadData()
            
            self.currentTempLable.text = String(format: "%.0f", response?.current.temp ?? "T") + " ºC"
            self.weatherTitleLable.text = (response?.current.weather[0].description)?.capitalized ?? "Weather Description"
            if let iconCode = response?.current.weather[0].icon {
                self.currentWeatherImage.image = UIImage(named: iconCode)
            }
        }
    }
    
    //MARK: UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apiResponse?.daily.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastTableViewCell", for: indexPath) as! ForecastTableViewCell
        if let apiResponse = apiResponse {
            cell.configure(data: apiResponse.daily[indexPath.row])
        }
        return cell
    }
    
    //MARK:  CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        
        manager.stopUpdatingLocation()
        
        NetworkService.shared.latitude = String(locValue.latitude)
        NetworkService.shared.longitude = String(locValue.longitude)
        getWeatherAndUpdateView()
    }
}

