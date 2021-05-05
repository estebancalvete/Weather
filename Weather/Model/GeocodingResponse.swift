//
//  GeocodingResponse.swift
//  Weather
//
//  Created by Esteban Calvete Iglesias on 05/05/2021.
//

import Foundation

class GeocodingResponse: Codable {
    let geocodingData: [GeocodingData]
    init(geocodingData: [GeocodingData]) {
        self.geocodingData = geocodingData
    }
}