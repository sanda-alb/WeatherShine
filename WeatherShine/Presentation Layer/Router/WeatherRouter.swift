//
//  WeatherRouter.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 5/23/22.
//

class WeatherRouter {
    
    weak var viewController: WeatherViewController?
    
    init (viewController: WeatherViewController) {
        self.viewController = viewController
    }
}


extension WeatherRouter: WeatherRouterInput {
}
