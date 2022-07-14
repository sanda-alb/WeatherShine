//
//  Protocols.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 5/23/22.
//

protocol  CurrentWeatherViewInput: class {
    func setCurrent(_ weather: Forecast)
    func setMock()
}

protocol CurrentWeatherViewOutput {
    func requestWeather(lat: Double, lon: Double)
    func openHourlyWeather()
}

protocol CurrentWeatherViewProtocol: CurrentWeatherViewInput {
    var output: CurrentWeatherViewOutput? { get set }
}
