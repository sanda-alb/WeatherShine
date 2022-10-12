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
    
    private let weatherService: WeatherServiceProtocol
    private let bag = DisposeBag()

    init(
        weatherService: WeatherServiceProtocol
    ) {
        self.weatherService = weatherService
    }
    
    func fetchData() {

    }
}
