//
//  HourlyWeatherConfigirator.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 6/3/22.
//
 
class HourlyWeatherModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? HourlyWeatherView {
            configure(with: viewController)
        }
    }
    
    private func configure(with viewController: HourlyWeatherView) {

        let router     = HourlyWeatherRouter(viewController: viewController)
        let interactor = HourlyWeatherInteractor(weatherService: WeatherAPIService())
        let presenter  = HourlyWeatherPresenter(
            view      : viewController,
            router    : router,
            interactor: interactor
        )
        
        interactor.output     = presenter
        viewController.output = presenter
    }
}
