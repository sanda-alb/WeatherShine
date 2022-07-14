//
//  UIImageView.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 7/14/22.
//

import Foundation
import UIKit

extension UIImageView {
    func setWeatherIcon(iconId: String) {
        switch iconId {
        case "01d", "01n":
            self.image = UIImage(named: "clearSky")
        case "02d", "02n":
            self.image = UIImage(named: "fewClouds")
        case "03d", "03n":
            self.image = UIImage(named: "scatteredClouds")
        case "04d", "04n":
            self.image = UIImage(named: "brockenClouds")
        case "09d", "09n":
            self.image = UIImage(named: "showerRain")
        case "10d", "10n":
            self.image = UIImage(named: "rain")
        case "11d", "11n":
            self.image = UIImage(named: "thunderstorm")
        case "13d", "13n":
            self.image = UIImage(named: "snow")
        case "50d", "50n":
            self.image = UIImage(named: "mist")
        case "placeholder":
            self.image = UIImage(named: "placeholder")
        default:
            self.image = UIImage(named: "placeholder")
        }
    }
}
