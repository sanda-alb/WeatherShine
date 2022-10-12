//
//  WeatherServiceProtocol.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 8/31/22.
//

import RxSwift

protocol WeatherServiceProtocol {
    func fetchWeather(lat: Double, lon: Double) -> Observable<Forecast>
    var data: Forecast? { get set }
}
