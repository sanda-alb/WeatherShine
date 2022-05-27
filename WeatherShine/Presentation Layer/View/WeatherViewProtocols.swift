//
//  Protocols.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 5/23/22.
//

protocol  WeatherViewInput: class {
    func getForecast(forecast: Forecast)
    func setCurrent(_ weather: Forecast)
}

protocol WeatherViewOutput {
    func requestWeather(lat: Double, lon: Double)
    
}


protocol WeatherViewProtocol: WeatherViewInput {
    var output: WeatherViewOutput? { get set }
}
