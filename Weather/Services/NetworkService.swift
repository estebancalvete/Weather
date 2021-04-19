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
 //   var iconCode: String = "10d@2x"
 //   let iconUrlString: String = "http://openweathermap.org/img/wn/%@.png"
    let session = URLSession(configuration: .default)

    //MARK: Functions

    static let shared = NetworkService()


    func getWeather(onSuccess: @escaping (OneCallResponse?) -> Void) {
        if let url = configureUrl() {
            let task = session.dataTask(with: url) { data, response, error in
                DispatchQueue.main.async {
                    if error != nil {
                        print("Error")
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
//    func getIcon()
    

    //MARK: Private

    private func configureUrl () -> URL? {
        let result: String = String(format: urlString, latitude, longitude, apiKey)
        return URL(string: result)
    }
    
//    private func getUrlIcon () -> URL? {
//        let result: String = String(format: iconUrlString, iconCode)
//        return URL (string: result)
//    }
}
