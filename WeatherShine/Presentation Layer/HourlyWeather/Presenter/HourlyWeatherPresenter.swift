//
//  HourlyWeatherPresenter.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 6/3/22.
//

import Foundation

class HourlyWeatherPresenter {
    
    // MARK: - Components
    
    weak var view : HourlyWeatherViewInput?
    var interactor: HourlyWeatherInteractorInput
    var router    : HourlyWeatherRouterInput
    
    // MARK: - Init
    
    init(
        view      : HourlyWeatherViewInput,
        router    : HourlyWeatherRouterInput,
        interactor: HourlyWeatherInteractorInput
    ) {
        self.view       = view
        self.router     = router
        self.interactor = interactor
    }
}

extension HourlyWeatherPresenter: HourlyWeatherViewOutput {
    func viewIsReady() {
        interactor.fetchData()
    }
}

extension HourlyWeatherPresenter: HourlyWeatherInteractorOutput {
    func obtainData(forecast: Forecast) {
        view?.setData(data: forecast)
    }
}
