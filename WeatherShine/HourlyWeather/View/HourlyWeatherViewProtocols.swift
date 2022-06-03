//
//  HourlyWeatherViewProtocols.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 6/3/22.
//

import Foundation 

protocol HourlytWeatherViewInput: class {

}

protocol HourlyWeatherViewOutput {
    
}


protocol HourlyWeatherViewProtocol: HourlytWeatherViewInput {
    var output: HourlyWeatherViewOutput? { get set }
}
