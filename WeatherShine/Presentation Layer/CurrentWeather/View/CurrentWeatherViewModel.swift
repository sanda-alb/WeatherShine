//
//  CurrentWeatherCell.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 5/27/22.
//

import Foundation

struct ViewModel {
    let temp: Double
    let humidity: Int
    let windSpeed: Double
    
    init(data: Forecast) {
        self.temp = data.current.temp
        self.humidity = data.current.humidity
        self.windSpeed = data.current.windSpeed
    }
}
