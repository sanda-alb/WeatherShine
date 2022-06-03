//
//  HourlyWeatherConfigirator.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 6/3/22.
//

import Foundation
 
class HourlyWeatherModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? HourlyWeatherView {
            configure(with: viewController)
        }
    }

    private func configure(with viewController: HourlyWeatherView) {

        let router = HourlyWeatherRouter(viewController: viewController)

        let presenter = HourlyWeatherPresenter(
            view: viewController,
            router: router
        )

        viewController.output = presenter
    }
}

//class CurrentWeatherModuleConfigurator {
//
//    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {
//
//        if let viewController = viewInput as? CurrentWeatherView {
//            configure(with: viewController)
//        }
//    }
//
//    private func configure(with viewController: CurrentWeatherView) {
//
//        let interactor = CurrentWeatherInteractor()
//
//        let router = CurrentWeatherRouter(viewController: viewController)
//
//        let presenter = CurrentWeatherPresenter(
//            view      : viewController,
//            interactor: interactor,
//            router    : router
//            )
//
//        interactor.output     = presenter
//        viewController.output = presenter
//    }
//}
