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
    let urlString: String = "https://api.openweathermap.org/data/2.5/onecall?lat=%@&lon=%@&appid=%@"
    let session = URLSession(configuration: .default)

    //var urlString: String = "https://api.openweathermap.org/data/2.5/onecall?lat=\(latitudeAsString)&lon=\(longitudeAsString)&appid=\(apiKey)"

    //MARK: Functions

    static let shared = NetworkService()


    func getWeather() {
        if let url = configureUrl() {
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print("Error")
                    return
                }
                if let data = data {
                    if let jsonString = String(data: data, encoding: .utf8) {
                        print(jsonString)
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
}
