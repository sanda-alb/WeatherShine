//
//  CurrentWeatherPresenter.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 5/23/22.
//
import Foundation

class CurrentWeatherPresenter {
    
    // MARK: - Components
    
    weak var view: CurrentWeatherViewInput?
    var interactor: CurrentWeatherInteractorInput
    var router: CurrentWeatherRouterInput
    
    // MARK: - Init
    
    init(
        view       : CurrentWeatherViewInput,
        interactor : CurrentWeatherInteractorInput,
        router     : CurrentWeatherRouterInput
    ) {
        self.view       = view
        self.interactor = interactor
        self.router     = router
    }
}

extension CurrentWeatherPresenter: CurrentWeatherViewOutput {
    func requestWeather(lat: Double, lon: Double) {
        interactor.fetchData(lat: lat, lon: lon)
    }
}

extension CurrentWeatherPresenter: CurrentWeatherInteractorOutput {
    func obtainData(forecast: Forecast) {
        view?.getForecast(forecast: forecast)
        view?.setCurrent(forecast)
        
    }
    
    func setMock() {
        view?.setMock() 
    }
}
