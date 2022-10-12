//
//  HourlyWeatherIneractorProtocols.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 8/1/22.
//

import Foundation

protocol HourlyWeatherInteractorInput {
    func fetchData()
}

protocol HourlyWeatherInteractorOutput: AnyObject {
    func obtainData(forecast: Forecast)
}
