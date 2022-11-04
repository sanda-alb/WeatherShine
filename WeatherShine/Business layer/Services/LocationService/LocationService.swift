//
//  LocationService.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 8/15/22.
//

import Foundation
import CoreLocation

final class LocationService: NSObject {
    
    private let locationManager: CLLocationManager
    var location: CLLocation?
    
    override init() {
        self.locationManager = CLLocationManager()
        super.init()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.showsBackgroundLocationIndicator = true
        locationManager.startUpdatingLocation()
    }
}

extension LocationService: LocationServiceInterface {
    
    func requestLocationAccessIfAvailable(withType type: LocationAccessType) -> Bool {
        switch type {
        case .always: locationManager.requestAlwaysAuthorization()
        case .whenInUse: locationManager.requestWhenInUseAuthorization()
        case .unavailable: return false
        }
        return true
    }
    
    func startMonitoringLocationUpdates() {
        locationManager.startUpdatingLocation()
    }
    
    func stopMonitoringLocationUpdates() {
        locationManager.stopUpdatingLocation()
    }
}

extension LocationService: CLLocationManagerDelegate {

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        switch locationManager.authorizationStatus {
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            NotificationCenter.default.post(Notification(name: LocationServiceNotificationName.authorizationStatusChanged.nameValue,
                                                         object: self,
                                                         userInfo: [LocationServiceNotificationInfoKey.authorizationStatus: LocationAccessType.always]))
        case .notDetermined: break
        case .restricted: fallthrough
        case .denied: fallthrough
        @unknown default:
            NotificationCenter.default.post(Notification(name: LocationServiceNotificationName.authorizationStatusChanged.nameValue,
                                                         object: self,
                                                         userInfo: [LocationServiceNotificationInfoKey.authorizationStatus: LocationAccessType.unavailable]))
            
            print("Location service. STATUS \(locationManager.authorizationStatus)")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinate = locations.last?.coordinate else { return }
        
        NotificationCenter.default.post(Notification(
            name: LocationServiceNotificationName.locationDidUpdate.nameValue,
            object: self,
            userInfo:
                [
                    LocationServiceNotificationInfoKey.location:
                        Location(lat: coordinate.latitude, lon: coordinate.longitude)
                ]
        )
        )
        
        UserDefaults.standard.set(coordinate.longitude, forKey: "lon")
        UserDefaults.standard.set(coordinate.latitude, forKey: "lat")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // TODO: publish a notification
    }
}
