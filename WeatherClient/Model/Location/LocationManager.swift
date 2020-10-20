//
//  LocationManager.swift
//  WeatherClient
//
//  Created by Matoshko Andrey on 5/16/20.
//  Copyright © 2020 Matoshko Andrey. All rights reserved.
//

import Foundation
import CoreLocation


final class LocationManager: NSObject {
    
    private let locationManager = CLLocationManager()
    
    var exposedLocation: CLLocation? {
        return self.locationManager.location
    }
    
    var delegate: CLLocationManagerDelegate! {
        didSet {
            locationManager.delegate = delegate
        }
    }
    
    var authStatus: CLAuthorizationStatus = .notDetermined
    
    override init() {
        super.init()
        self.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
    }
}

extension LocationManager: CLLocationManagerDelegate {
   
}

extension LocationManager {
    func getPlace(for location: CLLocation, completion: @escaping (CLPlacemark?) -> Void) {
        
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(location, preferredLocale: Locale(identifier: "en_US")) { (placemarks, error) in
            guard error == nil else {
                print("Error in \(#function): \(error!.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let placemark = placemarks?[0] else {
                print("Error in \(#function) placemark is nil")
                completion(nil)
                return
            }
            completion(placemark)
        }
    }
}

