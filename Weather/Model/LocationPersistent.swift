//
//  LocationPersistent.swift
//  Weather
//
//  Created by Martín Calvete Iglesias on 24/5/21.
//

import Foundation

struct LocationPersistentList: Codable {
    let elements: [LocationPersistent]
    init(elements: [LocationPersistent]) {
        self.elements = elements
    }
}

struct LocationPersistent: Codable {
    let name: String
    let state: String
    let lat: Double
    let lon: Double
    
    init(name: String, state: String, lat: Double, lon: Double) {
        self.name = name
        self.state = state
        self.lat = lat
        self.lon = lon
    }
}
