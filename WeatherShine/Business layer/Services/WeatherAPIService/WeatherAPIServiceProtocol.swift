//
//  WeatherAPIServiceProtocol.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 7/22/22.
//

import RxSwift

protocol WeatherAPIServiceProtocol: AnyObject {
    var weatherForecast: Forecast? { get }
    func fetchWeather(lat: Double, lon: Double) -> Observable<Forecast>
}
