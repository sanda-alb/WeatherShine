//
//  HourlyWeatherRouter.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 6/3/22.
//

import Foundation

class HourlyWeatherRouter {
    
    weak var viewController: HourlyWeatherView?
    
    init (viewController: HourlyWeatherView) {
        self.viewController = viewController
    }
}

extension HourlyWeatherRouter: HourlyWeatherRouterInput {
}
