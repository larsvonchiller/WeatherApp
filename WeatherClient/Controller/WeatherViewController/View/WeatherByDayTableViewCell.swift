//
//  WeatherByDayTableViewCell.swift
//  WeatherClient
//
//  Created by Matoshko Andrey on 5/16/20.
//  Copyright © 2020 Matoshko Andrey. All rights reserved.
//

import UIKit

class WeatherByDayTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var weatherTableView: UITableView!

    var data: [WeatherByHour]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        weatherTableView.dataSource = self
        weatherTableView.delegate = self
    }
}

extension WeatherByDayTableViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let weatherData = data else { return 0 }
        return weatherData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WeatherByDayInfoTableViewCell
        guard let weatherData = data else { return UITableViewCell() }
        cell.data = weatherData[indexPath.row]
        return cell
    }
}

extension WeatherByDayTableViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}
