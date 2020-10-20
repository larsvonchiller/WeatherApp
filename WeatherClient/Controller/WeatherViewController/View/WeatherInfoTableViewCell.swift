//
//  WeatherInfoTableViewCell.swift
//  WeatherClient
//
//  Created by Matoshko Andrey on 5/16/20.
//  Copyright © 2020 Matoshko Andrey. All rights reserved.
//

import UIKit

final class WeatherInfoTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var infoLabel: UILabel!
    
    var data: WeatherInfo? {
        didSet {
            updateData()
        }
    }
    
    private func updateData() {
        guard let data = data else { return }
        
        infoLabel.text = data.infoString
    }
}

