//
//  File.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 5/23/22.
//
import Alamofire

class WeatherInteractor: WeatherInteractorInput {
    
    weak var output: WeatherInteractorOutput?
    
    func fetchData(lat: Double, lon: Double) {
        let API_KEY = "582031dfb6b35824f6b6c0e85d5c8ccd"
        let parameters: [String: Any] =
        [ "lat": lat,
          "lon": lon,
          "exclude": "minutely,alerts",
          "units": "metric",
          "appid": API_KEY
        ]
        
        AF.request("https://api.openweathermap.org/data/2.5/onecall",parameters: parameters)
        .validate()
        .responseDecodable(of: Forecast.self) { response in
            switch response.result {
            case.success:
                print("Validation Successful")
                debugPrint(response)
            case let .failure(error):
                print(error)
            }
                
        }

//                    if let forecast = response.value {
//                    self.output.obtainData(forecast: forecast)
//                    }

    }
}

