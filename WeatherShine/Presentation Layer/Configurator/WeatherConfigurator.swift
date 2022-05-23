//
//  WeatherConfigurator.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 5/23/22.
//

import UIKit

class WeatherModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {
        
        if let viewController = viewInput as? WeatherViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: WeatherViewController) {

        let router = WeatherRouter(viewController: viewController)

        let presenter = WeatherPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = WeatherInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}

