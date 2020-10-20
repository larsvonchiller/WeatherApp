//
//  WeatherDetailsTableViewCell.swift
//  WeatherClient
//
//  Created by Matoshko Andrey on 5/16/20.
//  Copyright © 2020 Matoshko Andrey. All rights reserved.
//

import UIKit

final class WeatherDetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var detailsLabel: UILabel!
    
    var data: WeatherParameter? {
        didSet {
            updateData()
        }
    }
    
    private func updateData() {
        guard let data = data else { return }
        
        detailsLabel.attributedText = configureDetailsString(weatherData: data)
    }
    
    private func configureDetailsString(weatherData: WeatherParameter) -> NSAttributedString {
        let mutableAttributedString = NSMutableAttributedString()

        let parameterAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), .font: UIFont.systemFont(ofSize: 12)]
        let valueAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), .font: UIFont.boldSystemFont(ofSize: 15)]

        let parameterString = NSAttributedString(string: weatherData.parameterName + "\n", attributes: parameterAttributes)
        let valueString = NSAttributedString(string: weatherData.parameterValue, attributes: valueAttributes)
        
        mutableAttributedString.append(parameterString)
        mutableAttributedString.append(valueString)
        return mutableAttributedString
    }
}


