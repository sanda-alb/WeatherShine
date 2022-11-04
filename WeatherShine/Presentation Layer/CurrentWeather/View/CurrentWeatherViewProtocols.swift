//
//  Protocols.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 5/23/22.
//

protocol  CurrentWeatherViewInput: AnyObject {
    func set(state: DataState)
}

protocol CurrentWeatherViewOutput {
    func viewLoaded()
}

protocol CurrentWeatherViewProtocol: CurrentWeatherViewInput {
    var output: CurrentWeatherViewOutput? { get set }
}
