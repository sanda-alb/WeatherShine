//
//  Weather.swift
//  WeatherShine
//
//  Created by Sanda Albrecht on 5/25/22.
//
import Foundation

struct Forecast: Decodable {
    
    let lat: Double
    let lon: Double
    let timezone: String
    let timezoneOffset: Int
    let current: Current
    let hourly: [Hourly]
    let daily: [Daily]

    enum CodingKeys: String, CodingKey {
        case lat = "lat"
        case lon = "lon"
        case timezone = "timezone"
        case timezoneOffset = "timezone_offset"
        case current = "current"
        case hourly = "hourly"
        case daily = "daily"
    }
}

struct Current: Decodable {
    
    let time: Int
    let sunrise: Int
    let sunset: Int
    let temp: Double
    let feelsLike: Double
    let pressure: Int
    let humidity: Int
    let clouds: Int
    let visibility: Int
    let windSpeed: Double
    let weather: [Weather]
    
    enum CodingKeys: String, CodingKey {
        case time = "dt"
        case sunrise = "sunrise"
        case sunset = "sunset"
        case temp = "temp"
        case feelsLike = "feels_like"
        case pressure = "pressure"
        case humidity = "humidity"
        case clouds = "clouds"
        case visibility = "visibility"
        case windSpeed = "wind_speed"
        case weather = "weather"
    }
}

struct Hourly: Decodable {
    
    let time: Int
    let temp: Double
    let feelsLike: Double
    let pressure: Int
    let humidity: Int
    let clouds: Int
    let visibility: Int
    let windSpeed: Double
    let weather: [Weather]
    let precipitationProbability: Double
    
    enum CodingKeys: String, CodingKey {
        case time = "dt"
        case temp = "temp"
        case feelsLike = "feels_like"
        case pressure = "pressure"
        case humidity = "humidity"
        case clouds = "clouds"
        case visibility = "visibility"
        case windSpeed = "wind_speed"
        case weather = "weather"
        case precipitationProbability = "pop"
    }
}

struct Daily: Decodable {
    
    let time: Int
    let temp: DailyTemperature
    let feelsLike: FeelsLike
    let pressure: Int
    let humidity: Int
    let windSpeed: Double
    let weather: [Weather]
    let clouds: Int
    let precipitationProbability: Double
    let uvi: Double
    
    enum CodingKeys: String, CodingKey {
        case time = "dt"
        case temp = "temp"
        case feelsLike = "feels_like"
        case pressure = "pressure"
        case humidity = "humidity"
        case windSpeed = "wind_speed"
        case weather = "weather"
        case clouds = "clouds"
        case precipitationProbability = "pop"
        case uvi = "uvi"
    }
}

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case main = "main"
        case description = "description"
        case icon = "icon"
    }
}

struct DailyTemperature: Decodable {
    let day: Double
    let min: Double
    let max: Double
    let night: Double
    let evening: Double
    let morning: Double
    
    enum CodingKeys: String, CodingKey {
        case day = "day"
        case min = "min"
        case max = "max"
        case night = "night"
        case evening = "eve"
        case morning = "morn"
    }
}

struct FeelsLike: Decodable {
    let day: Double
    let night: Double
    let evening: Double
    let morning: Double
    
    enum CodingKeys: String, CodingKey {
        case day = "day"
        case night = "night"
        case evening = "eve"
        case morning = "morn"
    }
}
