//
//  LocationListTableViewCell.swift
//  Weather
//
//  Created by Martín Calvete Iglesias on 7/5/21.
//

import UIKit

class LocationListTableViewCell: UITableViewCell {
    @IBOutlet weak var label: UILabel!
    
    func configure(latitude: String, longitude: String) {
        label.text = String(format: "%@ - %@", latitude, longitude)
    }

}
