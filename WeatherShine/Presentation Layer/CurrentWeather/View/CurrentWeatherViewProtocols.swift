//
//  Protocols.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 5/23/22.
//

protocol  CurrentWeatherViewInput: class {
    func getForecast(forecast: Forecast)
    func setCurrent(_ weather: Forecast)
    func setMock()
}

protocol CurrentWeatherViewOutput {
    func requestWeather(lat: Double, lon: Double)
    
}


protocol CurrentWeatherViewProtocol: CurrentWeatherViewInput {
    var output: CurrentWeatherViewOutput? { get set }
}
