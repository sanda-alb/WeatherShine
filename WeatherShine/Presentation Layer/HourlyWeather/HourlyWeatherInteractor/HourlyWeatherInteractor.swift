//
//  HourlyWeatherInteractor.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 8/1/22.
//

import Foundation
import Alamofire
import RxSwift

class HourlyWeatherInteractor: HourlyWeatherInteractorInput {
    
    weak var output: HourlyWeatherInteractorOutput?
    
    private let weatherService: WeatherAPIServiceProtocol
    private let bag = DisposeBag()
    
    init(weatherService: WeatherAPIServiceProtocol) {
        self.weatherService = weatherService
    }
    
    func fetchData(lat: Double, lon: Double) {
        weatherService.fetchWeather(lat: lat, lon: lon)
            .subscribe(
                onNext: { response in
                    self.output?.obtainData(forecast: response)
                },
                onError: { error in
                    print("ERROR: \(error)")
                }
            ).disposed(by: bag)
    }
}

