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
        let parameters: [String: Any] = ["lat": lat, "lon": lon, "appid": API_KEY]
        
        AF.request("https://api.openweathermap.org/data/2.5/onecall",parameters: parameters).responseJSON { response in
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

