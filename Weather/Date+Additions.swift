//
//  Date+Additions.swift
//  Weather
//
//  Created by Martín Calvete Iglesias on 23/4/21.
//

import Foundation

extension Date {
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self).capitalized
    }
}
