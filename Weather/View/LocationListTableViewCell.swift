//
//  LocationListTableViewCell.swift
//  Weather
//
//  Created by Esteban Calvete Iglesias on 16/05/2021.
//

import UIKit

class LocationListTableViewCell: UITableViewCell {
    
    
    //MARK: IBOutlets
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var countryCodeLabel: UILabel!
    
    //MARK: Functions
    
    func configure(cityName: String, countryCode: String) {
        cityNameLabel.text = cityName
        countryCodeLabel.text = countryCode
    }
}
