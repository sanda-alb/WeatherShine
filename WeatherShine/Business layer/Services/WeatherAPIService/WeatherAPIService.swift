//
//  WeatherAPIService.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 7/22/22.
//

import Alamofire

class WeatherAPIService: WeatherAPIServiceProtocol {

    var weatherForecast: Forecast? 
    
    func fetchWeather(lat: Double, lon: Double) {
        let parameters: [String: Any] =
        [ "lat": lat,
          "lon": lon,
          "exclude": "minutely,alerts",
          "units": "metric",
          "appid": Constants.API_KEY
        ]
        
        AF.request(Constants.BASE_URL, parameters: parameters)
        .validate()
        .responseDecodable(of: Forecast.self) { response in
            switch response.result {
            case.success:
                print("Validation Successful")
//                debugPrint(response)
                if let forecast = response.value {
                    self.weatherForecast = forecast
//                    print(self.weatherForecast)
                }
                
            case let .failure(error):
                print(error)
                debugPrint(response)
                
            }
        }
    }
}
