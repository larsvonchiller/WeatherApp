//
//  WeatherInfo.swift
//  WeatherClient
//
//  Created by Matoshko Andrey on 5/16/20.
//  Copyright © 2020 Matoshko Andrey. All rights reserved.
//

import UIKit

struct WeatherInfo {
    
    let infoString: String
    
    init(weatherObject: WeatherObjectResponse) {
        let roundedMinTemp = (weatherObject.weatherDetails.minTemp - 273.15).rounded()
        let roundedMaxTemp = (weatherObject.weatherDetails.maxTemp - 273.15).rounded()

        self.infoString = "Today. Minimum temperature is \(String(format: "%.0f", roundedMinTemp))°C, max temperature is \(String(format: "%.0f", roundedMaxTemp))°C. \(weatherObject.weather[0].description)."
    }
}

