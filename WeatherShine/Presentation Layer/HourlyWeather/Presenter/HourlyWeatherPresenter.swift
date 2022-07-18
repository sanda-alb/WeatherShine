//
//  HourlyWeatherPresenter.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 6/3/22.
//

import Foundation

class HourlyWeatherPresenter {
    
    // MARK: - Components
    
    weak var view: HourlytWeatherViewInput?
    var router   : HourlyWeatherRouterInput
    
    let data     : Forecast
    
    // MARK: - Init
    
    init(
        view  : HourlytWeatherViewInput,
        router: HourlyWeatherRouterInput,
        data  : Forecast
    ) {
        self.view   = view
        self.router = router
        self.data   = data
    }
}

extension HourlyWeatherPresenter: HourlyWeatherViewOutput {
    func viewIsReady() {
        view?.setData(data: data)
    }
}
