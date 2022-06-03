//
//  CurrentWeatherConfigurator.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 5/23/22.
//

import UIKit

class CurrentWeatherModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {
        
        if let viewController = viewInput as? CurrentWeatherViewController {
            configure(with: viewController)
        }
    }

    private func configure(with viewController: CurrentWeatherViewController) {

        let interactor = CurrentWeatherInteractor()
        
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
