//
//  UIButton+Addition.swift
//  Weather
//
//  Created by Esteban Calvete Iglesias on 04/05/2021.
//

import UIKit

extension UIButton {
    func round() {
        layer.cornerRadius = bounds.height / 2
        clipsToBounds = true
    }
}
