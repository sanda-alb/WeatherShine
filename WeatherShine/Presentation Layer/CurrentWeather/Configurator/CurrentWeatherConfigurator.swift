//
//  CurrentWeatherConfigurator.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 5/23/22.
//

class CurrentWeatherModuleConfigurator {
    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {
        if let viewController = viewInput as? CurrentWeatherView {
            configure(with: viewController)
        }
    }

    private func configure(with viewController: CurrentWeatherView) {
        let weatherService = WeatherAPIService()
        let interactor = CurrentWeatherInteractor(weatherService: WeatherAPIService())
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
