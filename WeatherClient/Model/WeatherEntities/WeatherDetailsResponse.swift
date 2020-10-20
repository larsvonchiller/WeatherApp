//
//  WeatherDetails.swift
//  WeatherClient
//
//  Created by Matoshko Andrey on 5/16/20.
//  Copyright © 2020 Matoshko Andrey. All rights reserved.
//

import Foundation

struct WeatherDetailsResponse: Codable {
    
    let temp: Double
    let feelsLikeTemp: Double
    let minTemp: Double
    let maxTemp: Double
    let pressure: Double
    let humidity: Int
    
    private enum CodingKeys: String, CodingKey {
        case temp
        case feelsLikeTemp = "feels_like"
        case minTemp = "temp_min"
        case maxTemp = "temp_max"
        case pressure
        case humidity
    }
}
