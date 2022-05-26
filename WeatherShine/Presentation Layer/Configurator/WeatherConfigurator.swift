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
            configure(with: viewController)
        }
    }

    private func configure(with viewController: WeatherViewController) {

        let interactor = WeatherInteractor()
        
        let router = WeatherRouter(viewController: viewController)

        let presenter = WeatherPresenter(
            view      : viewController,
            interactor: interactor,
            router    : router
            )
        
        interactor.output     = presenter
        viewController.output = presenter
    } 
}
 
