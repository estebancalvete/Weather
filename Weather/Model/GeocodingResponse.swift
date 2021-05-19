
import Foundation

class GeocodingResponse: Codable {
    let geocodingData: [GeocodingData]
    init(geocodingData: [GeocodingData]) {
        self.geocodingData = geocodingData
    }
}
