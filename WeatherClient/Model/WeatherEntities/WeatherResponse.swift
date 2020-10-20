//
//  Weather.swift
//  WeatherClient
//
//  Created by Matoshko Andrey on 5/16/20.
//  Copyright © 2020 Matoshko Andrey. All rights reserved.
//

import Foundation

struct WeatherResponse: Codable {
    
    let weatherObjects: [WeatherObjectResponse]
    let city: City
    
    private enum CodingKeys: String, CodingKey {
        case weatherObjects = "list"
        case city
    }
}

