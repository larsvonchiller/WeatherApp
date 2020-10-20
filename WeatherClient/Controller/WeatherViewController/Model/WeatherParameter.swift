//
//  WeatherParametr.swift
//  WeatherClient
//
//  Created by Matoshko Andrey on 5/16/20.
//  Copyright © 2020 Matoshko Andrey. All rights reserved.
//

import Foundation

final class WeatherParameter {
    enum Parameter {
        case cloud
        case wind
        case humidity
        case feelsLike
        case minTemp
        case maxTemp
        case pressure
        case sunrise
        case sunset
    }
    
    var parameterName: String
    var parameterValue: String
    
    init(_ weatherResponse: WeatherResponse, parameter: Parameter) {
        let weatherObject = weatherResponse.weatherObjects[0]
        
        switch parameter {
        case .cloud:
            self.parameterName = "Cloudiness"
            self.parameterValue = "\(weatherObject.clouds?.cloudiness ?? 0)%"
        case .wind:
            self.parameterName = "Wind speed"
            self.parameterValue = "\(weatherObject.wind?.speed ?? 0) m\\s"
        case .humidity:
            self.parameterName = "Humidity"
            self.parameterValue = "\(weatherObject.weatherDetails.humidity)%"
        case .feelsLike:
            self.parameterName = "Feels like temperature"
            let roundedT = (weatherObject.weatherDetails.feelsLikeTemp - 273.15).rounded()
            self.parameterValue = "\(String(format: "%.0f", roundedT)) °C"
        case .minTemp:
            self.parameterName = "Min temperature"
            let roundedT = (weatherObject.weatherDetails.minTemp - 273.15).rounded()
            self.parameterValue = "\(String(format: "%.0f", roundedT)) °C"
        case .maxTemp:
            self.parameterName = "Max temperature"
            let roundedT = (weatherObject.weatherDetails.maxTemp - 273.15).rounded()
            self.parameterValue = "\(String(format: "%.0f", roundedT)) °C"
        case .pressure:
            self.parameterName = "Atmospheric pressure on the sea level"
            self.parameterValue = "\(weatherObject.weatherDetails.pressure) hPa"
        case .sunrise:
            self.parameterName = "Sunrise"
            self.parameterValue = Date(timeIntervalSince1970: weatherResponse.city.sunrise).time
        case .sunset:
            self.parameterName = "Sunset"
            self.parameterValue = Date(timeIntervalSince1970: weatherResponse.city.sunset).time
        }
    }
}

