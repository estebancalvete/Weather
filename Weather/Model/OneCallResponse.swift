//
//  OneCallResponse.swift
//  Weather
//
//  Created by Esteban Calvete Iglesias on 16/04/2021.
//

import Foundation

class OneCallResponse: Codable {
    let lat: Double
    let lon: Double
    let timezone: String
    let timezone_offset: Double
    let current: CurrentWeather
    let minutely: [MinutelyWeather]
    let hourly: [HourlyWeather]
    let daily: [DailyWeather]
    let alerts: [Alert]
}

class CurrentWeather: Codable {
    let dt: Double
    let sunrise: Double
    let sunset: Double
    let temp: Double
    let feels_like: Double
    let pressure: Double
    let humidity: Double
    let dew_point: Double
    let uvi: Double
    let clouds: Double
    let visibility: Double
    let wind_speed: Double
    let wind_deg: Double
    let wind_gust: Double
    let rain: AverageRain
    let snow: AverageSnow
    let weather: [WeatherInfo]
}

class MinutelyWeather: Codable {
    let dt: Double
    let precipitation: Double
}

class HourlyWeather: NSObject, Codable {
    let dt: Double
    let temp: Double
    let feels_like: Double
    let pressure: Double
    let humidity: Double
    let dew_point: Double
    let uvi: Double
    let clouds: Double
    let visibility: Double
    let wind_speed: Double
    let wind_deg: Double
    let wind_gust: Double
    let pop: Double
    let rain: AverageRain
    let snow: AverageSnow
    let weather: [WeatherInfo]

}

class DailyWeather: Codable {
    let dt: Double
    let sunrise: Double
    let sunset: Double
    let moonrise: Double
    let moonset: Double
    let moon_phase: Double
    let temp: ThermoTemps
    let feels_like: FeelsTemps
    let preassure: Double
    let humidity: Double
    let dew_point: Double
    let wind_speed: Double
    let wind_deg: Double
    let wind_gust: Double
    let weather: [WeatherInfo]
    let clouds: Double
    let pop: Double
    let rain: Double
    let snow: Double
    let uvi: Double
}

class Alert: Codable {
    let sender_name: String
    let event: String
    let start: Double
    let end: Double
    let description: String
}

class WeatherInfo: Codable {
    let id: Double
    let main: String
    let description: String
    let icon: String
}

class ThermoTemps: Codable {
    let day: Double
    let min: Double
    let max: Double
    let night: Double
    let eve: Double
    let morn: Double
}

class FeelsTemps: Codable {
    let day: Double
    let nihgt: Double
    let eve: Double
    let morn: Double
}

class AverageRain: Codable {
    let averageValue: Double
    enum CodingKeys: String, CodingKey {
        case averageValue = "1h"
    }
}

class AverageSnow: Codable {
    let averageValue: Double
    enum CodingKeys: String, CodingKey {
        case averageValue = "1h"
    }
}
