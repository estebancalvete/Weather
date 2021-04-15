//
//  OneCallResponse.swift
//  Weather
//
//  Created by Martín Calvete Iglesias on 15/4/21.
//

import Foundation

class OneCallResponse: NSObject, Codable {
    let lat: Double
    let lon: Double
    let timezone: String
    let current: CurrentWeather
    
//    {
//      "lat": 33.44,
//      "lon": -94.04,
//      "timezone": "America/Chicago",
//      "timezone_offset": -21600,
//      "current": {
//        "dt": 1595243443,
//        "sunrise": 1608124431,
//        "sunset": 1608160224,
//        "temp": 274.75,
//        "feels_like": 270.4,
//        "pressure": 1017,
//        "humidity": 96,
//        "dew_point": 274.18,
//        "uvi": 0,
//        "clouds": 90,
//        "visibility": 6437,
//        "wind_speed": 3.6,
//        "wind_deg": 320,
//        "weather": [
//          {
//            "id": 701,
//            "main": "Mist",
//            "description": "mist",
//            "icon": "50n"
//          }
//        ]
//      }
}

class CurrentWeather: NSObject, Codable {
    let dt: Double
    let temp: Double
    let weather: [WeatherDetail]
    
    //      "current": {
    //        "dt": 1595243443,
    //        "sunrise": 1608124431,
    //        "sunset": 1608160224,
    //        "temp": 274.75,
    //        "feels_like": 270.4,
    //        "pressure": 1017,
    //        "humidity": 96,
    //        "dew_point": 274.18,
    //        "uvi": 0,
    //        "clouds": 90,
    //        "visibility": 6437,
    //        "wind_speed": 3.6,
    //        "wind_deg": 320,
    //        "weather": [
    //          {
    //            "id": 701,
    //            "main": "Mist",
    //            "description": "mist",
    //            "icon": "50n"
    //          }
    //        ]
}

class WeatherDetail: NSObject, Codable {
    let id: Double
    let main: String
    

    //        "weather": [
    //          {
    //            "id": 701,
    //            "main": "Mist",
    //            "description": "mist",
    //            "icon": "50n"
    //          }
    //        ]
}
