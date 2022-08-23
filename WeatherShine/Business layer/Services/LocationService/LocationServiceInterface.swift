//
//  LocationServiceInterface.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 8/19/22.
//

import Foundation

protocol LocationServiceInterface: AnyObject {
    func requestLocationAccessIfAvailable(withType type: LocationAccessType) -> Bool
    func startMonitoringLocationUpdates()
    func stopMonitoringLocationUpdates()
}
