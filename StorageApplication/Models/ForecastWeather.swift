//
//  ForecastWeather.swift
//  StorageApplication
//
//  Created by Александр Уткин on 17.06.2020.
//  Copyright © 2020 Александр Уткин. All rights reserved.
//

import Foundation

struct Forecast: Decodable {
    let lat, lon: Double
    let timezone: String
    let timezoneOffset: Int
    let daily: [Daily]
    
    enum CodingKeys: String, CodingKey {
        case lat, lon, timezone
        case timezoneOffset = "timezone_offset"
        case daily
    }
}

struct Daily: Decodable {
    let dt, sunrise, sunset: Int
    let temp: Temp
    let feelsLike: FeelsLike
    let pressure, humidity: Int
    let dewPoint, windSpeed: Double
    let windDeg: Int
    let weather: [Weather1]
    let clouds: Int
    let uvi: Double
    
    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, temp
        case feelsLike = "feels_like"
        case pressure, humidity
        case dewPoint = "dew_point"
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case weather, clouds, uvi
    }
}

struct Weather1: Decodable {
    let id: Int
    let main, weatherDescription, icon: String
    
    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

struct FeelsLike: Decodable {
    let day, night, eve, morn: Double
}

struct Temp: Decodable {
    let day, min, max, night: Double
    let eve, morn: Double
}
