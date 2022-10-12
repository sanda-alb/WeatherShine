//
//  LocationServiceNotificationInfoKey..swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 8/19/22.
//

import Foundation

enum LocationServiceNotificationInfoKey {
    case authorizationStatus
    case location
}

extension LocationServiceNotificationInfoKey {
    var stringValue: String {
        switch self {
        case .authorizationStatus: return "LocationServiceNotificationInfoKey_authorizationStatus"
        case .location: return "LocationServiceNotificationInfoKey_location"
        }
    }
}
