//
//  HourlyWeatherConfigirator.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 6/3/22.
//

import RxSwift
 
class HourlyWeatherModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController, weatherForecast: Observable<Forecast>) {

        if let viewController = viewInput as? HourlyWeatherView {
            configure(with: viewController, weatherForecast: weatherForecast)
        }
    }
    
    private func configure(with viewController: HourlyWeatherView, weatherForecast: Observable<Forecast>) {
        let router     = HourlyWeatherRouter(viewController: viewController)
        let interactor = HourlyWeatherInteractor(
            weatherService: WeatherService.shared,
            weatherForecast: weatherForecast
        )
        let presenter  = HourlyWeatherPresenter(
            view      : viewController,
            router    : router,
            interactor: interactor
        )
        
        interactor.output     = presenter
        viewController.output = presenter
    }
}
