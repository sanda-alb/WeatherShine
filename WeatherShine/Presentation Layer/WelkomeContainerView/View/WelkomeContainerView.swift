//
//  Container.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 7/20/22.
//

import UIKit
import CoreLocation
import Kingfisher

final class WelcomeContainerViewController: BottomSheetContainerViewController
<CurrentWeatherView, HourlyWeatherView> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var data: Forecast?
    
    // MARK: - Data
    
    private var latitude: Double? = nil
    private var longitude: Double? = nil
    
    private let locationManager = CLLocationManager()
    private var currentLocation: CLLocation?
    
}

// MARK: - CLLocationManagerDelegate

extension WelcomeContainerViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
      print("didFailWithError \(error.localizedDescription)")
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        if !locations.isEmpty, currentLocation == nil {
            currentLocation = locations.last
            locationManager.stopUpdatingLocation()
            requestWeatherForLocation()
        }
    }
    
    func requestWeatherForLocation() {
        guard let currentLocation = currentLocation else { return }
        let lat = currentLocation.coordinate.latitude
        let lon = currentLocation.coordinate.longitude
//        output?.requestWeather(lat: lat, lon: lon)
    }
}


