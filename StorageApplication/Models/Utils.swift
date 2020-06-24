//
//  Utils.swift
//  StorageApplication
//
//  Created by Александр Уткин on 17.06.2020.
//  Copyright © 2020 Александр Уткин. All rights reserved.
//

import Foundation
import CoreData

func windDirection(degree : Float) -> String {
    let directions = ["Северный", "Северо-восточный", "Восточный", "Юго-восточный", "Южный", "Юго-западный", "Западный", "Северо-западный"]
    let i: Int = Int((degree + 33.75)/45)
    return directions[i % 8]
}

func updateWeatherIcon(condition: Int) -> String {
    let hour = Calendar.current.component(.hour, from: Date())
    switch (condition) {
    case 200...232 : // шторм
        switch hour {
        case 6..<18 :
            return "storm"
        default :
            return "storm-night"
        }
        
    case 300...321 : // легкий дождь
        switch hour {
        case 6..<18 :
            return "hail"
        default :
            return "night-rain"
        }
        
    case 500...531 : // дождь
        switch hour {
        case 6..<18 :
            return "storm"
        default :
            return "night-rain"
        }
        
    case 600...622 : //снег
        switch hour {
        case 6..<18 :
            return "snowy"
        default :
            return "night-snow"
        }
        
    case 701...741 : //туман
        return "fog"
        
    case 800 : // ясно
        switch hour {
        case 6..<18 :
            return "sun"
        default :
            return "night-4"
        }
        
    case 801 : // частичная облачность
        return "cloudy-3"
        
    case 802 : //облачно
        switch hour {
        case 6..<18 :
            return "cloud"
        default :
            return "cloud-moon"
        }
        
    case 803...804 : //сильная облачность
        return "cloudy"
        
    default:
        return "windy"
    }
}
