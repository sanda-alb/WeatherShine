//
//  HourlyWeatherConfigirator.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 6/3/22.
//

import RxSwift
 
class HourlyWeatherModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController, weatherEvent: Observable<Forecast>) {

        if let viewController = viewInput as? HourlyWeatherView {
            configure(with: viewController, weatherEvent: weatherEvent)
        }
    }
    
    private func configure(with viewController: HourlyWeatherView, weatherEvent: Observable<Forecast>) {
        let router     = HourlyWeatherRouter(viewController: viewController)
        let interactor = HourlyWeatherInteractor(
            weatherService: WeatherService.shared,
            weatherEvent: weatherEvent
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
