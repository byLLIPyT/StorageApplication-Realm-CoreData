//
//  Weather.swift
//  StorageApplication
//
//  Created by Александр Уткин on 17.06.2020.
//  Copyright © 2020 Александр Уткин. All rights reserved.
//

import Foundation

struct Model: Decodable {
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone, id: Int
    let name: String
    let cod: Int
}

struct Clouds: Decodable {
    let all: Int
}

struct Coord: Decodable {
    let lon, lat: Double
}

struct Main: Decodable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity: Int
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

struct Sys: Decodable {
    let type, id: Int
    let country: String
    let sunrise, sunset: Int
}

struct Weather: Decodable {
    let id: Int
    let main, weatherDescription, icon: String
    
    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

struct Wind: Decodable {
    let speed: Int
    let deg: Int
}
