//
//  Date+Extensions.swift
//  WeatherClient
//
//  Created by Matoshko Andrey on 5/16/20.
//  Copyright © 2020 Matoshko Andrey. All rights reserved.
//

import Foundation

extension Date {
    
    var day: Int {
        return Calendar.current.component(.day, from: self)
    }
    
    var hour: Int {
           return Calendar.current.component(.hour, from: self)
       }
    
    var weekday: String {
        let df = DateFormatter()
        return df.weekdaySymbols[Calendar.current.component(.weekday, from: self) - 1]
    }
    
    var time: String {
        let df = DateFormatter()
        df.dateFormat = "HH:mm"
        return df.string(from: self)
    }
}
