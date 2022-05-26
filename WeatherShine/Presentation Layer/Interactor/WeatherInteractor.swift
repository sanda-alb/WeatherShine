//
//  File.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 5/23/22.
//
import Alamofire

class WeatherInteractor: WeatherInteractorInput {
    
    weak var output: WeatherInteractorOutput?
    
    func fetchData(lat: Double, lng: Double) {
        let API_KEY = "0e0ab86e-d831-11ec-881e-0242ac130002-0e0ab8dc-d831-11ec-881e-0242ac130002"
        let params = "airTemperature,pressure,gust"
        let headers: HTTPHeaders = [.authorization(API_KEY)]
        let parameters: [String: Any] = ["lat": lat, "lng": lng, "params": params]
        
        AF.request("https://api.stormglass.io/v2/weather/point",parameters: parameters, headers: headers).responseJSON { response in
            debugPrint(response)
        }
        

//            .validate()
//            .responseDecodable(of: [Mission].self) { response in
//                switch response.result {
//                case .success:
//                    print("Validation Successful")
//                    if let missions = response.value {
//                    self.output.obtainData(missions: missions)
//                    }
//                case let .failure(error):
//                    print(error)
//                }
//            }
    }
}

