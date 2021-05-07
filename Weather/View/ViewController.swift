//
//  ViewController.swift
//  Weather
//
//  Created by Esteban Calvete Iglesias on 14/04/2021.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, UITableViewDataSource, UICollectionViewDataSource, CLLocationManagerDelegate, NetworkServiceDelegate, LocationListViewControllerDelegate {
    

    //MARK: Variables
    
    var apiResponse: OneCallResponse? = nil
    var revGeoResponse: ReverseGeocodingResponse? = nil
    var geoResponse: GeocodingResponse? = nil
    var newtworkService: NetworkService? = nil
    
    //MARK: Constants
    
    let maxCollectionRows = 12
    let locationManager = CLLocationManager()
    
    
    //MARK: IBOutlets
    
    @IBOutlet weak var cityNameLable: UILabel!
    @IBOutlet weak var weatherTitleLable: UILabel!
    @IBOutlet weak var currentTempLable: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var forecastWeatherTable: UITableView!
    @IBOutlet weak var hourlyForecastCollection: UICollectionView!
    
    //MARK: Live Cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        forecastWeatherTable.dataSource = self
        
        hourlyForecastCollection.dataSource = self
        
        newtworkService = NetworkService()
        newtworkService?.delegate = self
        
        configureLocation()
        
    }
    
    //MARK: IBActions
    
    @IBAction func locationListButtonDidTouchUpInside(_ sender: Any) {
        let locListViewContr = LocationListViewController.create(delegate: self)
        self.present(locListViewContr, animated: true, completion: nil)
        // If we are using a Navigation Controller:
        // self.navigationController?.present(locListViewContr, animated: true, completion: nil)
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
        newtworkService?.getWeather()
        newtworkService?.getLocationName()
    }
    
    //MARK: NetworkServiceDelegate Functions
    
    func networkServiceDidGetWeatherData(response: OneCallResponse?) {
        self.apiResponse = response
        
        self.forecastWeatherTable.reloadData()
        
        self.hourlyForecastCollection.reloadData()
        
        self.currentTempLable.text = String(format: "%.0f", response?.current.temp ?? "T") + " ºC"
        self.weatherTitleLable.text = (response?.current.weather[0].description)?.capitalized ?? "Weather Description"
        if let iconCode = response?.current.weather[0].icon {
            self.currentWeatherImage.image = UIImage(named: iconCode)
        }
    }
    
    func networkServiceDidGetLocationName(response: ReverseGeocodingResponse?) {
        self.revGeoResponse = response
        
        self.cityNameLable.text = response?.geocodingData.first?.name ?? "Sin City"
    }
    
    func networkServiceDidGetLocationCoordinates(response: GeocodingResponse?) {
        self.geoResponse = response
        newtworkService?.latitude = String(response?.geocodingData.first?.lat ?? 0.0)
        newtworkService?.longitude = String(response?.geocodingData.first?.lon ?? 0.0)
        getWeatherAndUpdateView()
    }
    
    
    
    
    //MARK: CCLocationDelegate Functions
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
                
        manager.stopUpdatingLocation()
                
        newtworkService?.latitude = String(locValue.latitude)
        newtworkService?.longitude = String(locValue.longitude)
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
    
    //MARK: UICollectionViewDataSource Functions
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let availableRows = apiResponse?.hourly.count ?? 0
        return min(availableRows, maxCollectionRows)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HourlyForecastCollectionViewCell", for: indexPath) as! HourlyForecastCollectionViewCell
        if let apiResponse = apiResponse {
            cell.configure(data: apiResponse.hourly[indexPath.row])
        }
        return cell
    }
    
    //MARK: LocationListViewControllerDelegate Functions
    
    func locationListViewControllerDidSelectCoordinate(coordinate: CLLocationCoordinate2D) {
        newtworkService?.latitude = NSNumber(value: coordinate.latitude).stringValue
        newtworkService?.longitude = NSNumber(value: coordinate.longitude).stringValue
        getWeatherAndUpdateView()
    }
}

