//
//  NetworkManager.swift
//  WeatherClient
//
//  Created by Matoshko Andrey on 5/16/20.
//  Copyright © 2020 Matoshko Andrey. All rights reserved.
//

import Foundation

final class NetworkManager {
    
    static func getCurrentWeather(city: String, completion: @escaping (_ value: WeatherResponse?, _ error: String?)->()) {
        NetworkService.request(.getCurrentWeather(city)) { (status, value) in
            guard
                let data = value as? Data,
                let weatherResponse = try? JSONDecoder().decode(WeatherResponse.self, from: data) else {
                    completion(nil, "error in response")
                    return
            }
            completion(weatherResponse, nil)
        }
    }
    
    static func getCurrentCityViaIP(completion: @escaping (_ value: IpResponse?, _ error: String?)->()) {
        NetworkService.request(.getCurrentIpInfo) { (status, value) in
            guard
                let data = value as? Data,
                let ipResponse = try? JSONDecoder().decode(IpResponse.self, from: data) else {
                    completion(nil, "error in response")
                    return
            }
            completion(ipResponse, nil)
        }
    }

}
