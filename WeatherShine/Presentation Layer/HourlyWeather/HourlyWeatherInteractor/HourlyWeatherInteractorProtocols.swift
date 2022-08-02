//
//  HourlyWeatherIneractorProtocols.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 8/1/22.
//

import Foundation

protocol HourlyWeatherInteractorInput {
    func fetchData(lat: Double, lon: Double)
}

protocol HourlyWeatherInteractorOutput: AnyObject {
    func obtainData(forecast: Forecast)
//    func setMock()
}
