//
//  State.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 9/1/22.
//

import Foundation

enum DataState {
    case empty
    case location
    case data
    case loading
    case error
    
    func setState() {
        switch self {
        case .empty:
            print("Empty state")
        case .location:
            print("Location State")
        case .loading:
            print("Loading State")
        case .data:
           print("Data State")
        case .error:
            print("Error")
        }
    }
}
