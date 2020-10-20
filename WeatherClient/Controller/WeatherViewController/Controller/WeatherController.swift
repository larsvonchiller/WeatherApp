//
//  WeatherController.swift
//  WeatherClient
//
//  Created by Matoshko Andrey on 5/16/20.
//  Copyright © 2020 Matoshko Andrey. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherViewControllerDataSource {
    func getWeatherData(vc: WeatherViewController, location: CLLocation?)
    func loadWeather(vc: WeatherViewController, locationPermission: CLAuthorizationStatus)
    func collectionViewItemsCount() -> Int
    func tableViewItemsCount() -> Int
    func collectionViewItem(indexPath: IndexPath) -> WeatherByHour
    func tableViewItem(indexPath: IndexPath, type: WeatherViewController.WeatherCellType) -> Any
    func tableViewCellType(indexPath: IndexPath) -> WeatherViewController.WeatherCellType
}

final class WeatherController: NSObject {
    
    private let viewController: WeatherViewController
    private var weatherResponse: WeatherResponse? {
        didSet {
            UserDefaults.standard.set(weatherResponse.data, forKey: "storedWeather")
        }
    }
    
    private var weatherParameters: [WeatherParameter] {
        guard let weatherResponse = weatherResponse else {
            return [WeatherParameter]()
        }
        let parametersArray = [WeatherParameter(weatherResponse, parameter: .cloud),
                               WeatherParameter(weatherResponse, parameter: .feelsLike),
                               WeatherParameter(weatherResponse, parameter: .humidity),
                               WeatherParameter(weatherResponse, parameter: .maxTemp),
                               WeatherParameter(weatherResponse, parameter: .minTemp),
                               WeatherParameter(weatherResponse, parameter: .pressure),
                               WeatherParameter(weatherResponse, parameter: .wind),
                               WeatherParameter(weatherResponse, parameter: .sunrise),
                               WeatherParameter(weatherResponse, parameter: .sunset)]
        
        return parametersArray
    }
    
    private func getWeatherData(city: String, vc: WeatherViewController) {
        DispatchQueue.main.async {
            vc.activityIndicatorView.startAnimating()
        }
        
        NetworkManager.getCurrentWeather(city: city) { (response, error) in
            guard
                let response = response,
                error == nil else {
                    DispatchQueue.main.async {
                        vc.activityIndicatorView.stopAnimating()
                        vc.addAlert(message: error!)
                    }
                    return
            }
            
            self.weatherResponse = response
            let weatherVM = WeatherViewModel(weatherResponse: response)
            
            DispatchQueue.main.async {
                vc.updateData(viewModel: weatherVM)
                vc.activityIndicatorView.stopAnimating()
            }
        }
    }
    
    private func loadStoredData(vc: WeatherViewController) {
        guard
            let data = UserDefaults.standard.value(forKey: "storedWeather") as? Data,
            let decodedWeather = try? JSONDecoder().decode(WeatherResponse.self, from: data) else { return }
        
        let weatherVM = WeatherViewModel(weatherResponse: decodedWeather)
        self.weatherResponse = decodedWeather
        DispatchQueue.main.async {
            vc.updateData(viewModel: weatherVM, toggleUpdate: true)
        }
        print(#function)
    }
    
    private func startWeatherFlow(vc: WeatherViewController, location: CLLocation?) {
        guard let exposedLocation = location else {
            NetworkManager.getCurrentCityViaIP { (ipResponse, error) in
                guard
                    error == nil,
                    let ipResponse = ipResponse else {
                        DispatchQueue.main.async {
                            vc.activityIndicatorView.stopAnimating()
                            vc.addAlert(message: error!)
                        }
                        return
                }
                print("ipResponse flow")
                self.getWeatherData(city: ipResponse.city, vc: vc)
            }
            return
        }
        
        vc.getLocationManager().getPlace(for: exposedLocation) { placemark in
            guard
                let placemark = placemark,
                let city = placemark.locality else { return }
            print("location flow")
            self.getWeatherData(city: city, vc: vc)
        }
    }
    
    init(vc: WeatherViewController) {
        self.viewController = vc
    }
}

extension WeatherController: WeatherViewControllerDataSource {
    func loadWeather(vc: WeatherViewController, locationPermission: CLAuthorizationStatus) {
        guard UserDefaults.standard.value(forKey: "storedWeather") == nil else {
                   self.loadStoredData(vc: vc)
                   return
               }
        
        startWeatherFlow(vc: vc, location: vc.getLocationManager().exposedLocation)
    }
    
    func getWeatherData(vc: WeatherViewController, location: CLLocation?) {
        startWeatherFlow(vc: vc, location: location)
    }
    
    func tableViewItem(indexPath: IndexPath, type: WeatherViewController.WeatherCellType) -> Any {
        switch type {
        case .tableView:
            guard let weatherObjects = weatherResponse?.weatherObjects else { fatalError() }
            
            let weatherArray = weatherObjects
                .compactMap({
                    return WeatherByHour(weatherObject: $0)
                }).filter({
                    return $0.date.day != Date().day && $0.date.hour == 15
                }).sorted (by: {
                    return $0.date < $1.date
                })
            
            return weatherArray
        case .detail:
            guard let _ = weatherResponse else { fatalError() }
            
            return weatherParameters[indexPath.row - 2]
        case .info:
            guard let weatherObject = weatherResponse?.weatherObjects[0] else { fatalError() }
            
            return WeatherInfo(weatherObject: weatherObject)
        }
    }
    
    func tableViewCellType(indexPath: IndexPath) -> WeatherViewController.WeatherCellType {
        switch indexPath.row {
        case 0:
            return .tableView
        case 1:
            return .info
        default:
            return .detail
        }
    }
    
    func collectionViewItemsCount() -> Int {
        guard let _ = weatherResponse else { return 0 }
        return 8
    }
    
    func tableViewItemsCount() -> Int {
        guard let _ = weatherResponse else { return 0 }
        return weatherParameters.count + 2
    }
    
    func collectionViewItem(indexPath: IndexPath) -> WeatherByHour {
        guard let weatherObjects = weatherResponse?.weatherObjects else { fatalError() }
        
        let weatherArray = weatherObjects
            .compactMap({
                return WeatherByHour(weatherObject: $0)
            })
            .sorted (by: {
                return $0.date < $1.date
            })
        
        return weatherArray[indexPath.row]
    }
}

extension WeatherController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .notDetermined:
            print("notDetermined")
        case .authorizedWhenInUse, .authorizedAlways, .denied:
            self.getWeatherData(vc: self.viewController, location: self.viewController.getLocationManager().exposedLocation)
        default:
            print(#function, #line)
        }
    }
}
