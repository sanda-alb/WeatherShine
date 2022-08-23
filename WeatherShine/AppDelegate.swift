//
//  AppDelegate.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 5/16/22.
//

import UIKit
import Alamofire
import RxSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    private let weatherService: WeatherAPIServiceProtocol = WeatherAPIService()
    private let bag = DisposeBag()
    private let locationService: LocationServiceInterface = LocationService()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        locationService.requestLocationAccessIfAvailable(withType: .whenInUse)
        
        weatherService.fetchWeather(
            lat: UserDefaults.standard.double(forKey: "lat"),
            lon: UserDefaults.standard.double(forKey: "lon")
        )
            .subscribe(
                onNext: { response in
//                    print(response)
                },
                onError: { error in
                    print("ERROR: \(error)")
                }
            ).disposed(by: bag)
        return true
    }
    
        

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}
