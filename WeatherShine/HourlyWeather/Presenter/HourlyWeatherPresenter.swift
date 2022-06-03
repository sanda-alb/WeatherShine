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
    
    // MARK: - Init
    
    init(
        view  : HourlytWeatherViewInput,
        router: HourlyWeatherRouterInput
    ) {
        self.view   = view
        self.router = router
    }
}

extension HourlyWeatherPresenter: HourlyWeatherViewOutput {

}
