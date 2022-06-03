//
//  CurrentWeatherRouter.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 5/23/22.
//

class CurrentWeatherRouter {
    
    weak var viewController: CurrentWeatherViewController?
    
    init (viewController: CurrentWeatherViewController) {
        self.viewController = viewController
    }
}


extension CurrentWeatherRouter: CurrentWeatherRouterInput {
}
