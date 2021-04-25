//
//  ReverseGeocodingResponse.swift
//  Weather
//
//  Created by Esteban Calvete Iglesias on 25/04/2021.
//

import Foundation

class ReverseGeocodingResponse: Codable {
    let geocodingData: [GeocodingData]
    init(geocodingData: [GeocodingData]) {
        self.geocodingData = geocodingData
    }
}

class GeocodingData: Codable {
    let name: String
    let local_names: LocalNames
    let lat: Double
    let lon: Double
    let country: String
    let state: String?
}

class LocalNames: Codable {
    let ascii: String
    let feature_name: String
}
