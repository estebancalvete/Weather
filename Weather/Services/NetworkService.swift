//
//  NetworkService.swift
//  Weather
//
//  Created by Esteban Calvete Iglesias on 14/04/2021.
//

import Foundation

class NetworkService {
    
    //MARK: Variables

    var latitude: String = "52.5200"
    var longitude: String = "13.4050"
    let apiKey: String = "7564695d8d9f46060ac0234173fa0ea0"
    let urlString: String = "https://api.openweathermap.org/data/2.5/onecall?lat=%@&lon=%@&appid=%@&units=metric"
    let locationUrlString: String = "https://api.openweathermap.org/geo/1.0/reverse?lat=%@&lon=%@&limit=1&appid=%@"
    let session = URLSession(configuration: .default)

    //MARK: Functions

    static let shared = NetworkService()


    func getWeather(onSuccess: @escaping (OneCallResponse?) -> Void) {
        if let url = configureUrl() {
            let task = session.dataTask(with: url) { data, response, error in
                DispatchQueue.main.async {
                    if error != nil {
                        print("Error Getting Weather Data")
                        return
                    }
                    if let data = data {
                        let oneCallResponse = try? JSONDecoder().decode(OneCallResponse.self, from: data)
                        onSuccess(oneCallResponse)
                    }
                }
            }
            task.resume()
        }
    }
    func getLocation(onSuccess: @escaping (GeocodingResponse?) -> Void) {
        if let url = configureLocationUrl() {
            let task = session.dataTask(with: url) { data, response, error in
                DispatchQueue.main.async {
                    if error != nil {
                        print("Error Getting Location Data")
                        return
                    }
                    if let data = data {
                        let locationResponse = try? JSONDecoder().decode(GeocodingResponse.self, from: data)
                        onSuccess(locationResponse)
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
}
