//
//  WeatherService.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 8/31/22.
//

import Alamofire
import RxSwift
import Dispatch

class WeatherService {
    
    private init() { }
    
    static var shared = WeatherService()
    
    var forecast: Forecast?
}

extension WeatherService: WeatherServiceProtocol {
   
    var data: Forecast? {
        get {
            return forecast
        }
        set {
            forecast = newValue
        }
    }
    
    func fetchWeather(lat: Double, lon: Double) -> Observable<Forecast> {
        return Observable.create{ observer -> Disposable in
    
                let parameters: [String: Any] =
                [ "lat": lat,
                  "lon": lon,
                  "exclude": "minutely,alerts",
                  "units": "metric",
                  "appid": Constants.API_KEY
                ]
    
                AF.request(
                    Constants.BASE_URL,
                    method: .get,
                    parameters: parameters
                )
                .responseDecodable(of: Forecast.self) { response in
                    if let error = response.error{
                        observer.onError(error)
                        print(error)
                    }
                    if let forecast = response.value {
                        self.forecast = forecast
                        self.data = forecast
                        observer.onNext(forecast)
                    }
                    observer.onCompleted()
                }
                return Disposables.create()
            }
        }
}




