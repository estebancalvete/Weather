//
//  NetworkService.swift
//  Weather
//
//  Created by Esteban Calvete Iglesias on 14/04/2021.
//

import Foundation

protocol NetworkServiceDelegate: AnyObject {
    func networkServiceDidGetWeatherData(response: OneCallResponse?)
    func networkServiceDidGetLocationName(response: ReverseGeocodingResponse?)
    func networkServiceDidGetLocationCoordinates(response: GeocodingResponse?)
}

class NetworkService {
    
    //MARK: Variables

    var latitude: String = "0"
    var longitude: String = "0"
    let apiKey: String = "7564695d8d9f46060ac0234173fa0ea0"
    var cityName: String = ""
    let urlString: String = "https://api.openweathermap.org/data/2.5/onecall?lat=%@&lon=%@&appid=%@&units=metric"
    let locationUrlString: String = "https://api.openweathermap.org/geo/1.0/reverse?lat=%@&lon=%@&limit=1&appid=%@"
    let coordinatesUrlStirn: String = "https://api.openweathermap.org/geo/1.0/direct?q=%@&limit=5&appid=%@"
    let session = URLSession(configuration: .default)
    
    weak var delegate: NetworkServiceDelegate?

    //MARK: Functions

    static let shared = NetworkService()


    func getWeather() {
        if let url = configureUrl() {
            let task = session.dataTask(with: url) { data, response, error in
                DispatchQueue.main.async {
                    if error != nil {
                        print("Error Getting Weather Data")
                        return
                    }
                    if let data = data {
                        let oneCallResponse = try? JSONDecoder().decode(OneCallResponse.self, from: data)
                        self.delegate?.networkServiceDidGetWeatherData(response: oneCallResponse)
                    }
                }
            }
            task.resume()
        }
    }
    func getLocationName() {
        if let url = configureLocationUrl() {
            let task = session.dataTask(with: url) { data, response, error in
                DispatchQueue.main.async {
                    if error != nil {
                        print("Error Getting Location Data")
                        return
                    }
                    if let data = data {
                        if let geocodingDatas = try? JSONDecoder().decode([GeocodingData].self, from: data) {
                            let locationResponse = ReverseGeocodingResponse(geocodingData: geocodingDatas)
                            self.delegate?.networkServiceDidGetLocationName(response: locationResponse)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func getLocationCoordinates() {
        if let url = configureCoordinatesUrl() {
            let task = session.dataTask(with: url) { data, response, error in
                DispatchQueue.main.async {
                    if error != nil {
                        print("Error Getting Location Coordinates")
                        return
                    }
                    if let data = data {
                        if let geocodingDatas = try? JSONDecoder().decode([GeocodingData].self, from: data) {
                            let locationResponse = GeocodingResponse(geocodingData: geocodingDatas)
                            self.delegate?.networkServiceDidGetLocationCoordinates(response: locationResponse)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    

    //MARK: Private

    private func configureUrl () -> URL? {
        let result: String = String(format: urlString, latitude, longitude, apiKey)
        return URL(string: result)
    }
    
    private func configureLocationUrl () -> URL? {
        let result: String = String(format: locationUrlString, latitude, longitude, apiKey)
        return URL(string: result)
    }
    private func configureCoordinatesUrl () -> URL? {
        let result: String = String(format: coordinatesUrlStirn, cityName, apiKey)
        return URL(string: result)
    }
}
