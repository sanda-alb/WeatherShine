//
//  WelkomeContainerInteractorProtocols.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 7/21/22.
//

protocol WelkomeContainerInteractorInput {
    func fetchData(lat: Double, lon: Double)
}

protocol WelkomeContainerInteractorOutput: AnyObject {
    func obtainData(forecast: Forecast)
    func setMock()
}
