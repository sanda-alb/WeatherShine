//
//  WelcomeContainerInteractor.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 7/21/22.
//

//import Alamofire

class WelkomeContainerInteractor: WelkomeContainerInteractorInput {
    
    weak var output: WelkomeContainerInteractorOutput?
    
    func fetchData(lat: Double, lon: Double) {
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
//
//            }
//        }
    }
}
