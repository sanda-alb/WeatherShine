//
//  File.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 5/23/22.
//
import Alamofire

class WeatherInteractor: WeatherInteractorInput {
    
    weak var output: WeatherInteractorOutput!
    
    func fetchData() {
        AF.request("https://api.stormglass.io/v2")
        let params = ["airTemperature", "pressure", "cloudCover", "currentSpeed", "humidity" ]
        let headers: HTTPHeaders = [.authorization("0e0ab86e-d831-11ec-881e-0242ac130002-0e0ab8dc-d831-11ec-881e-0242ac130002")
        ]
        
        let lat = 58.7984;
        let lng = 17.8081;
        

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

