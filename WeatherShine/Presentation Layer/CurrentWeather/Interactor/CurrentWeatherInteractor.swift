//
//  File.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 5/23/22.
//

import Foundation
import Alamofire
import RxSwift

class CurrentWeatherInteractor: CurrentWeatherInteractorInput {
    
    weak var output: CurrentWeatherInteractorOutput?
    
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
