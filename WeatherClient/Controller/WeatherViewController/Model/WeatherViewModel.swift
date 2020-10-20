//
//  WeatherViewModel.swift
//  WeatherClient
//
//  Created by Matoshko Andrey on 5/16/20.
//  Copyright © 2020 Matoshko Andrey. All rights reserved.
//

import UIKit

struct WeatherViewModel {
    
    private let temp: Double
    private let minTemp: Double
    private let maxTemp: Double
    private let date: Date
    private let state: WeatherState
    let city: String
    
    var tempString: String {
        return String(format: "%.0f", temp - 273.15) + "°"
    }
    
    var minMaxTempString: NSAttributedString {
        let mutableString = NSMutableAttributedString()
        let minTempAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)]
        let maxTempAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
        
        let maxTempString = NSAttributedString(string: String(format: "%.0f", (minTemp - 273.15).rounded()) + "  ", attributes: maxTempAttributes)
        let minTempString = NSAttributedString(string: String(format: "%.0f", (maxTemp - 273.15).rounded()), attributes: minTempAttributes)
        
        mutableString.append(maxTempString)
        mutableString.append(minTempString)
        return mutableString
    }
    
    var weekdayString: NSAttributedString {
        let mutableString = NSMutableAttributedString()
        let weekdayAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
                                                                .font: UIFont.systemFont(ofSize: 15)]
        let todayAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1),
                                                              .font: UIFont.boldSystemFont(ofSize: 15)]
        
        let weekdayString = NSAttributedString(string: date.weekday, attributes: weekdayAttributes)
        let todayString = NSAttributedString(string: "Today: ", attributes: todayAttributes)
        
        mutableString.append(todayString)
        mutableString.append(weekdayString)
        return mutableString
    }
    
    var backgroundImage: UIImage? {
        return state.backgroundImage
    }
    
    init(weatherResponse: WeatherResponse) {
        self.city = weatherResponse.city.name
        self.temp = weatherResponse.weatherObjects[0].weatherDetails.temp
        self.minTemp = weatherResponse.weatherObjects[0].weatherDetails.minTemp
        self.maxTemp = weatherResponse.weatherObjects[0].weatherDetails.maxTemp
        self.date = Date(timeIntervalSince1970: weatherResponse.weatherObjects[0].timestamp)
        self.state = WeatherState.init(rawValue: weatherResponse.weatherObjects[0].weather[0].state) ?? .another
    }
}
