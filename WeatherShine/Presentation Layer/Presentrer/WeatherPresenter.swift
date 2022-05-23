//
//  WeatherPresenter.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 5/23/22.
//

class WeatherPresenter {
    
    weak var view: WeatherViewInput!
    var interactor: WeatherInteractorInput!
    var router: WeatherRouterInput!

    func viewIsReady() {

    }

}

extension WeatherPresenter: WeatherViewOutput {
}

extension WeatherPresenter: WeatherInteractorOutput {
}

