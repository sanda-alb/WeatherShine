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
    private let locationService: LocationServiceInterface
    private let bag = DisposeBag()
    
    init(
        weatherService: WeatherAPIServiceProtocol,
        locationService: LocationServiceInterface
    ) {
        self.weatherService = weatherService
        self.locationService = locationService
    }
    
    func fetchData(lat: Double, lon: Double) {
//        weatherService.fetchWeather(lat: lat, lon: lon)
//            .subscribe(
//                onNext: { response in
//                    self.output?.obtainData(forecast: response)
//                },
//                onError: { error in
//                    print("ERROR: \(error)")
//                }
//            ).disposed(by: bag)
        
        
        guard let forecast = weatherService.weatherForecast else { return }

        self.output?.obtainData(forecast: forecast)
    
 
    }
}

