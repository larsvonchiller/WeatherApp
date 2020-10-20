//
//  WeatherByHourCollectionViewCell.swift
//  WeatherClient
//
//  Created by Matoshko Andrey on 5/16/20.
//  Copyright © 2020 Matoshko Andrey. All rights reserved.
//

import UIKit

class WeatherByHourCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var weatherImageView: UIImageView!
    @IBOutlet private weak var temperatureLabel: UILabel!
    
    var data: WeatherByHour? {
        didSet {
            weatherImageView.image = nil
            updateData()
        }
    }
    
    private func updateData() {
        guard let data = data else { return }
        
        timeLabel.text = "\(data.date.weekday), \(data.date.day)\n\(data.date.hour):00"
        weatherImageView.image = data.state.image
        temperatureLabel.text = "\(String(format: "%.0f", data.temperature))°"
    }
}
