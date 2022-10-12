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
    
    private let weatherService: WeatherServiceProtocol
    private let weatherEvent: Observable<Forecast>
    private let bag = DisposeBag()
    
    init(
        weatherService: WeatherServiceProtocol,
        weatherEvent: Observable<Forecast>
    ) {
        self.weatherService = weatherService
        self.weatherEvent = weatherEvent
    }
    
    func fetchData() {
        self.weatherEvent.subscribe(
            onNext: { response in
                guard let forecast = WeatherService.shared.forecast else { return }
                self.output?.obtainData(forecast: forecast)
                print(forecast)
            },
            onError: { error in
                print("ERROR: \(error)")
            }
        ).disposed(by: bag)
    }
}
