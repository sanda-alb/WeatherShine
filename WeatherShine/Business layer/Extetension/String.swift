//
//  String.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 11/4/22.
//

import Foundation

public extension String {
    
    func setCity() -> String {
        if self.contains("/") {
            guard let slashIndex = self.firstIndex(of: "/") else { return "" }
            let cityName = self[self.index(after: slashIndex)...]
            return String(cityName)
        }
        return self
    }
}
