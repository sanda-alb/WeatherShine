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
    let current: CurrentWeather
    let hourly: [HourlyWeather]
    let daily: [DailyWeather]

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

struct CurrentWeather: Decodable {
    
    let time: Int
    let sunrise: Int
    let sunset: Int
    let temp: Double
    let feelsLike: Double
    let pressure: Int
    let humidity: Int
    let uvi: Double
    let clouds: Int
    let visibility: Int
    let windSpeed: Double
    let windDirection: Int
    let weather: [Weather]
    
    enum CodingKeys: String, CodingKey {
        case time = "dt"
        case sunrise = "sunrise"
        case sunset = "sunset"
        case temp = "temp"
        case feelsLike = "feels_like"
        case pressure = "pressure"
        case humidity = "humidity"
        case uvi = "uvi"
        case clouds = "clouds"
        case visibility = "visibility"
        case windSpeed = "wind_speed"
        case windDirection = "wind_deg"
        case weather = "weather"
    }
}

struct HourlyWeather: Decodable {
    
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

struct DailyWeather: Decodable {
    
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
