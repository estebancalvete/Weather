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
    var geoResponse: ReverseGeocodingResponse? = nil
    
    //MARK: Constants
    
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
        
        forecastWeatherTable.dataSource = self
        
        configureLocation()
        
    }
    //MARK: Functions
    
    private func configureLocation() {
        self.locationManager.requestAlwaysAuthorization()
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
        NetworkService.shared.getLocationName { (response) in
            
            self.geoResponse = response
            
            self.cityNameLable.text = response?.geocodingData.first?.name ?? "Sin City"
        }
    }
    
    
    
    //MARK: CCLocationDelegate Functions
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
                
                manager.stopUpdatingLocation()
                
                NetworkService.shared.latitude = String(locValue.latitude)
                NetworkService.shared.longitude = String(locValue.longitude)
                getWeatherAndUpdateView()
    }
    
    
    //MARK: UITableViewDataSource Functions

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
}

