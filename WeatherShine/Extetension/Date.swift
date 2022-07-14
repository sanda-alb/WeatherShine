//
//  Date.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 7/11/22.
//

import Foundation

public extension Int {
 
    func setTime() -> String {
        var date = NSDate(timeIntervalSince1970: TimeInterval(self))
        let utcDateFormatter = DateFormatter()
        utcDateFormatter.dateFormat = "HH:mm"
        let time = utcDateFormatter.string(from: date as Date)
        return time
    }
}
