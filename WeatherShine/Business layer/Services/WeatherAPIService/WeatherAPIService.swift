//
//  WeatherAPIService.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 7/22/22.
//

import Alamofire
import RxSwift
import Dispatch

class WeatherAPIService: WeatherAPIServiceProtocol {
    
    var weatherForecast: Forecast?

    private let disposeBag = DisposeBag()
    
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
                    self.weatherForecast = forecast
                    observer.onNext(forecast)
                }
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
}
