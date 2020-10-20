//
//  WeatherByHour.swift
//  WeatherClient
//
//  Created by Matoshko Andrey on 5/16/20.
//  Copyright © 2020 Matoshko Andrey. All rights reserved.
//

import UIKit

struct WeatherByHour {
    
    let timestamp: Double
    let date: Date
    let state: WeatherState
    let temperature: Double
    let dailyMinTemp: Double
    let dailyMaxTemp: Double
    
    init(weatherObject: WeatherObjectResponse) {
        self.timestamp = weatherObject.timestamp
        self.date = Date(timeIntervalSince1970: weatherObject.timestamp)
        self.state = WeatherState.init(rawValue: weatherObject.weather[0].state) ?? WeatherState.another
        self.temperature = weatherObject.weatherDetails.temp - 273.15
        self.dailyMinTemp = weatherObject.weatherDetails.minTemp - 273.15
        self.dailyMaxTemp = weatherObject.weatherDetails.maxTemp - 273.15
    }
}
