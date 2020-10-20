//
//  WeatherObject.swift
//  WeatherClient
//
//  Created by Matoshko Andrey on 5/16/20.
//  Copyright © 2020 Matoshko Andrey. All rights reserved.
//

import Foundation

struct WeatherObjectResponse: Codable {
    
    let timestamp: Double
    let weather: [WeatherInfoResponse]
    let weatherDetails: WeatherDetailsResponse
    let clouds: Clouds?
    let wind: Wind?
    
    private enum CodingKeys: String, CodingKey {
        case timestamp = "dt"
        case weather
        case weatherDetails = "main"
        case clouds
        case wind
    }
}
