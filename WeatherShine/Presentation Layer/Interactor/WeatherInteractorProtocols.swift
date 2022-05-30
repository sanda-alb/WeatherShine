//
//  WeatherInteractorProtocols.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 5/23/22.
//

protocol WeatherInteractorInput {
    func fetchData(lat: Double, lon: Double)
}

protocol WeatherInteractorOutput: class {
    func obtainData(forecast: Forecast)
    func setMock()
}
