//
//  WeatherInfo.swift
//  WeatherClient
//
//  Created by Matoshko Andrey on 5/16/20.
//  Copyright © 2020 Matoshko Andrey. All rights reserved.
//

import Foundation

struct WeatherInfoResponse: Codable {
    
    let state: String
    let description: String
    
    private enum CodingKeys: String, CodingKey {
        case state = "main"
        case description
    }
}
