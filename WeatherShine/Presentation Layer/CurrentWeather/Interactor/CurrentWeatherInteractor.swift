//
//  File.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 5/23/22.
//
import Alamofire
import RxSwift
import RxAlamofire

class CurrentWeatherInteractor: CurrentWeatherInteractorInput {
    
    weak var output: CurrentWeatherInteractorOutput?
    
    private let weatherService: WeatherAPIServiceProtocol
    
    init(weatherService: WeatherAPIServiceProtocol) {
        self.weatherService = weatherService
    }
    
    func fetchData(lat: Double, lon: Double) {
        
        weatherService.fetchWeather(lat: lat, lon: lon)
     
        
//        let parameters: [String: Any] =
//        [ "lat": lat,
//          "lon": lon,
//          "exclude": "minutely,alerts",
//          "units": "metric",
//          "appid": Constants.API_KEY
//        ]
//
//        AF.request(Constants.BASE_URL, parameters: parameters)
//        .validate()
//        .responseDecodable(of: Forecast.self) { response in
//            switch response.result {
//            case.success:
//                print("Validation Successful")
////                debugPrint(response)
//                if let forecast = response.value {
//                    self.output?.obtainData(forecast: forecast)
//                }
//
//            case let .failure(error):
//                self.output?.setMock()
//                print(error)
//                debugPrint(response)
//            }
//        }
//        self.output?.obtainData(forecast: weatherService.weatherForecast)
    }
}


