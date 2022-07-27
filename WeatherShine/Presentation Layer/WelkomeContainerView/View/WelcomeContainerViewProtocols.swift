//
//  WelcomeContainerViewProtocols.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 7/21/22.
//

protocol  WelkomeContainerViewInput: AnyObject {
    func setCurrent(_ weather: Forecast)
    func setMock()
}

protocol WelkomeContainerViewOutput {
    func requestWeather(lat: Double, lon: Double)
}

protocol WelkomeContainerViewProtocol: CurrentWeatherViewInput {
    var output: WelkomeContainerViewOutput? { get set }
}

