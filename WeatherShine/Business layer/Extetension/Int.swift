//
//  Date.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 7/11/22.
//

import Foundation

public extension Int {
    
    func isToday() -> Bool {
        var isToday: Bool
        let currentDate = Calendar.current
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        if currentDate.isDateInToday(date) { isToday = true } else {isToday = false }
return isToday
  }
 
    func setTime() -> String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(self))
        let utcDateFormatter = DateFormatter()
        utcDateFormatter.dateFormat = "HH:mm"
        let time = utcDateFormatter.string(from: date as Date)
        return time
    }
    
    func setWindDirection() -> String {
        var direction = ""
        
        switch self {
        case 0...23, 337...360:
            direction = "North"
        case 24...68:
            direction = "NE"
        case 69...113:
            direction = "East"
        case 114...158:
            direction = "SE"
        case 159...203:
            direction = "South"
        case 204...248:
            direction = "SW"
        case 249...293:
            direction = "West"
        case 294...336:
            direction = "NW"
        default:
            direction = "Unknown"
        }
        
        return direction
    }
    
    func setUVCategory() -> String {
        var category = ""
        switch self {
    case 0...2:
        category = "Low"
    case 3...5:
        category = "Moderate"
    case 6...7:
        category = "High"
    case 8...10:
        category = "Very high"
    case 11...20:
        category = "Extreme"
    default:
        category = "Unknown"
    }
        return category
    }
}
