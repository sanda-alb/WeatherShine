//
//  State.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 9/1/22.
//

import Foundation

enum DataState {
    case loading
    case hasData(weather: Forecast)
    case error
}
