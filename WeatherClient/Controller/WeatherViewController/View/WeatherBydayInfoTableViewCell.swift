//
//  WeatherBydayInfoTableViewCell.swift
//  WeatherClient
//
//  Created by Matoshko Andrey on 5/16/20.
//  Copyright © 2020 Matoshko Andrey. All rights reserved.
//

import UIKit

final class WeatherByDayInfoTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var dayLabel: UILabel!
    @IBOutlet private weak var weatherImageView: UIImageView!
    @IBOutlet private weak var minTemperatureLabel: UILabel!
    @IBOutlet private weak var maxTemperatureLabel: UILabel!
    
    var data: WeatherByHour? {
        didSet {
            weatherImageView.image = nil
            updateData()
        }
    }
    
    private func updateData() {
        guard let data = data else { return }
        
        dayLabel.text = data.date.weekday
        weatherImageView.image = data.state.image
        minTemperatureLabel.text = String(format: "%.0f", data.dailyMinTemp)
        maxTemperatureLabel.text = String(format: "%.0f", data.dailyMaxTemp)
    }
}




