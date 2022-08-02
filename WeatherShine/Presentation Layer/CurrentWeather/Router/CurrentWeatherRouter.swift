//
//  CurrentWeatherRouter.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 5/23/22.
//

class CurrentWeatherRouter {
    
    weak var viewController: CurrentWeatherView?
    
    init (viewController: CurrentWeatherView) {
        self.viewController = viewController
    }
    
    func showHourlyWeather(data: Forecast) {
        let vc = HourlyWeatherView()
        HourlyWeatherModuleConfigurator().configureModuleForViewInput(
            viewInput: vc
        )
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}

extension CurrentWeatherRouter: CurrentWeatherRouterInput {
    func openHourlyWeather(data: Forecast) {
        showHourlyWeather(data: data)
    }
}
