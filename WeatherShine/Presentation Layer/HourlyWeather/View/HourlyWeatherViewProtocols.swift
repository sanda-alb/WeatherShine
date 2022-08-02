//
//  HourlyWeatherViewProtocols.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 6/3/22.
//

import Foundation 

protocol HourlyWeatherViewInput: AnyObject {
    func setData(data: Forecast)
}

protocol HourlyWeatherViewOutput {
    func viewIsReady()
    func requestWeather(lat: Double, lon: Double)
}

protocol HourlyWeatherViewProtocol: HourlyWeatherViewInput {
    var output: HourlyWeatherViewOutput? { get set }
}
