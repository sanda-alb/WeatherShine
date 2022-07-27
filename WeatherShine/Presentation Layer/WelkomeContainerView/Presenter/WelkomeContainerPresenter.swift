//
//  WelkomeContainerPresenter.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 7/21/22.
//

import Foundation

class WelkomeContainerPresenter {
    
    // MARK: - Components
    
    weak var view: WelkomeContainerViewInput?
    var interactor: WelkomeContainerInteractorInput
    
    // MARK: - Init
    
    init(
        view       : WelkomeContainerViewInput,
        interactor : WelkomeContainerInteractorInput
    ) {
        self.view       = view
        self.interactor = interactor
    }
}

extension WelkomeContainerPresenter: WelkomeContainerViewOutput {
    
    func requestWeather(lat: Double, lon: Double) {
        interactor.fetchData(lat: lat, lon: lon)
    }
}

extension WelkomeContainerPresenter: WelkomeContainerInteractorOutput {
    func obtainData(forecast: Forecast) {
        view?.setCurrent(forecast)
    }
    
    func setMock() {
        view?.setMock()
    }
}
