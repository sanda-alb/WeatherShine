//
//  Protocols.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 5/23/22.
//

protocol  CurrentWeatherViewInput: AnyObject {
    func setCurrent(_ weather: Forecast)
}

protocol CurrentWeatherViewOutput {
    func viewLoaded()
}

protocol CurrentWeatherViewProtocol: CurrentWeatherViewInput {
    var output: CurrentWeatherViewOutput? { get set }
}
