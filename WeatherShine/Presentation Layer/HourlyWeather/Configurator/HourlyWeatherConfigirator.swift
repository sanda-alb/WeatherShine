//
//  HourlyWeatherConfigirator.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 6/3/22.
//
 
class HourlyWeatherModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController, data: Forecast) {

        if let viewController = viewInput as? HourlyWeatherView {
            configure(with: viewController, data: data)
        }
    }
    
    private func configure(with viewController: HourlyWeatherView, data: Forecast) {

        let router = HourlyWeatherRouter(viewController: viewController)

        let presenter = HourlyWeatherPresenter(
            view: viewController,
            router: router,
            data: data
        )

        viewController.output = presenter
    }
}
