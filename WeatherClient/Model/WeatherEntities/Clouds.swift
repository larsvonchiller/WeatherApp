//
//  Clouds.swift
//  WeatherClient
//
//  Created by Matoshko Andrey on 5/16/20.
//  Copyright © 2020 Matoshko Andrey. All rights reserved.
//

import Foundation

struct Clouds: Codable {
    
    let cloudiness: Double
    
    private enum CodingKeys: String, CodingKey {
        case cloudiness = "all"
    }
}
