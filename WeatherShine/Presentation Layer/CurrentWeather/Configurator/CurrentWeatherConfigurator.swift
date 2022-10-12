//
//  CurrentWeatherConfigurator.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 5/23/22.
//

import Foundation

class CurrentWeatherModuleConfigurator {
    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {
        if let viewController = viewInput as? CurrentWeatherView {
            configure(with: viewController)
        }
    }

    private func configure(with viewController: CurrentWeatherView) {
        let interactor = CurrentWeatherInteractor(weatherService: WeatherService.shared)
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
