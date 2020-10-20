//
//  ApiRouter.swift
//  WeatherClient
//
//  Created by Matoshko Andrey on 5/16/20.
//  Copyright © 2020 Matoshko Andrey. All rights reserved.
//

import Foundation

enum ApiRouter {
    
    case getCurrentWeather(_ city: String)
    case getCurrentIpInfo
    
    var scheme: String {
        switch self {
        case .getCurrentIpInfo:
            return "http"
        default:
            return "https"
        }
    }
    
    var host: String {
        switch self {
        case .getCurrentIpInfo:
            return "ip-api.com"
        default:
            return "api.openweathermap.org"
        }
    }
    
    
    var path: String {
        let api = "/data/2.5/"
        
        switch self {
        case .getCurrentWeather:
            return api + "forecast"
        case .getCurrentIpInfo:
            return "/json"
        }
    }
    
    var method: String {
        switch self {
        case .getCurrentWeather(_):
            return "GET"
        case .getCurrentIpInfo:
            return "GET"
        }
    }
    
    var query: [URLQueryItem] {
        let apiKey = "723bce07901515c1098874a079024f17"
        
        switch self {
        case .getCurrentWeather(let city):
            return [URLQueryItem(name: "q", value: city),
                    URLQueryItem(name: "mode", value: "json"),
                    URLQueryItem(name: "appid", value: apiKey)]
        default:
            return [URLQueryItem]()
        }
    }
    
    
}
