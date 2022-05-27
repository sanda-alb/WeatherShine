//
//  WeatherPresenter.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 5/23/22.
//
import Foundation

class WeatherPresenter {
    
    // MARK: - Components
    
    weak var view: WeatherViewInput?
    var interactor: WeatherInteractorInput
    var router: WeatherRouterInput
    
    // MARK: - Init
    
    init(
        view       : WeatherViewInput,
        interactor : WeatherInteractorInput,
        router     : WeatherRouterInput
    ) {
        self.view       = view
        self.interactor = interactor
        self.router     = router
    }
}

extension WeatherPresenter: WeatherViewOutput {
    func requestWeather(lat: Double, lon: Double) {
        interactor.fetchData(lat: lat, lon: lon)
    }
}

extension WeatherPresenter: WeatherInteractorOutput {
    func obtainData(forecast: Forecast) {
        view?.getForecast(forecast: forecast)
    }
}
