//
//  CurrentWeatherConfigurator.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 5/23/22.
//

import Foundation
import RxSwift

class CurrentWeatherModuleConfigurator {
    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController, weatherForecast: Observable<Forecast>) {
        if let viewController = viewInput as? CurrentWeatherView {
            configure(with: viewController, weatherForecast: weatherForecast)
        }
    }

    private func configure(with viewController: CurrentWeatherView, weatherForecast: Observable<Forecast>) {
        let interactor = CurrentWeatherInteractor(weatherService: WeatherService.shared, weatherForecast: weatherForecast)
        let router = CurrentWeatherRouter(viewController: viewController)
        
        let presenter = CurrentWeatherPresenter(
            view      : viewController,
            interactor: interactor,
            router    : router
        )
        
        interactor.output     = presenter
        viewController.output = presenter
    }
}
