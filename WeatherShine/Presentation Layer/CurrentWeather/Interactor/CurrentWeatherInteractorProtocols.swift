//
//  CurrentWeatherInteractorProtocols.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 5/23/22.
//

protocol CurrentWeatherInteractorInput {
    func fetchData(lat: Double, lon: Double)
}

protocol CurrentWeatherInteractorOutput: AnyObject {
    func obtainData(forecast: Forecast)
    func setMock()
}
