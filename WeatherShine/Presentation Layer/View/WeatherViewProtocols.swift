//
//  Protocols.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 5/23/22.
//

protocol  WeatherViewInput: class {
    
}

protocol WeatherViewOutput {
    func viewLoaded(lat: Double, lng: Double)
    
}


protocol WeatherViewProtocol: WeatherViewInput {
    var output: WeatherViewOutput? { get set }
}
