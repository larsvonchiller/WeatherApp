//
//  WeatherViewController.swift
//  WeatherClient
//
//  Created by Matoshko Andrey on 5/16/20.
//  Copyright © 2020 Matoshko Andrey. All rights reserved.
//

import UIKit

final class WeatherViewController: UIViewController {
    
    enum WeatherCellType {
        case tableView
        case detail
        case info
    }
    
    //MARK: - IBOutlets
    
    @IBOutlet private weak var weatherImageView: UIImageView!
    @IBOutlet private weak var infoView: UIView!
    @IBOutlet private weak var currentCityLabel: UILabel!
    @IBOutlet private weak var currentTemperatureLabel: UILabel!
    @IBOutlet private weak var currentWeekdayLabel: UILabel!
    @IBOutlet private weak var currentMinMaxTemperatureLabel: UILabel!
    @IBOutlet private weak var mainInfoStackView: UIStackView!
    @IBOutlet private weak var weatherTableView: UITableView!
    @IBOutlet private weak var weatherCollectionView: UICollectionView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: - Properties
    
    private var controller: WeatherController!
    private var dataSource: WeatherViewControllerDataSource!
    private let locationManager = LocationManager()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setController()
        setSources()
        setupUI()
        
        locationManager.delegate = controller
        dataSource.loadWeather(vc: self, locationPermission: locationManager.authStatus)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight {
             mainInfoStackView.axis = .horizontal
        } else {
            mainInfoStackView.axis = .vertical
        }
    }
 
    override func viewWillLayoutSubviews() {
         if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight {
            mainInfoStackView.axis = .horizontal
        }
    }
    
    private func setupUI() {
        activityIndicatorView.hidesWhenStopped = true
        calculateCollectionViewCellFrame()
    }
    
    func updateData(viewModel: WeatherViewModel, toggleUpdate: Bool = false) {
        currentCityLabel.text = viewModel.city
        currentTemperatureLabel.text = viewModel.tempString
        currentWeekdayLabel.attributedText = viewModel.weekdayString
        currentMinMaxTemperatureLabel.attributedText = viewModel.minMaxTempString
        weatherImageView.image = viewModel.backgroundImage
        
        weatherTableView.reloadData()
        weatherCollectionView.reloadData()
        
        if toggleUpdate {
            dataSource.getWeatherData(vc: self, location: locationManager.exposedLocation)
        }
    }
    
    private func calculateCollectionViewCellFrame() {
        let collectionViewSize = weatherCollectionView.bounds.size
        
        let cellHeight = floor(collectionViewSize.height * 1 )
        let cellWidth = cellHeight * 0.85
        
        let insetX = CGFloat(0)
        let insetY = CGFloat(0)
        
        let layout = weatherCollectionView!.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        weatherCollectionView.contentInset = UIEdgeInsets(top: insetY, left: insetX, bottom: insetY, right: insetX)
    }
    
    private func setController() {
        let controller = WeatherController(vc: self)
        self.controller = controller
        dataSource = controller
    }
    
    private func setSources() {
        weatherTableView.dataSource = self
        weatherTableView.delegate = self
        
        weatherCollectionView.dataSource = self
    }
    
    func getLocationManager() -> LocationManager { locationManager }
}
  
//MARK: - Table View Data Source

extension WeatherViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.tableViewItemsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let currentCellType = dataSource?.tableViewCellType(indexPath: indexPath) else {
            return UITableViewCell()
        }
        
        switch currentCellType {
        case .tableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! WeatherByDayTableViewCell
            let cellData = dataSource?.tableViewItem(indexPath: indexPath, type: .tableView) as? [WeatherByHour]
            cell.data = cellData
            return cell
        case .detail:
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! WeatherDetailsTableViewCell
            let cellData = dataSource?.tableViewItem(indexPath: indexPath, type: .detail) as? WeatherParameter
            cell.data = cellData
            return cell
        case .info:
            let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as! WeatherInfoTableViewCell
            let cellData = dataSource?.tableViewItem(indexPath: indexPath, type: .info) as? WeatherInfo
            cell.data = cellData
            return cell
        }
    }
}

//MARK: - Table View Delegate

extension WeatherViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let currentType = dataSource?.tableViewCellType(indexPath: indexPath) else { return 80 }
        
        switch currentType {
        case .tableView:
            return 200
        case .detail:
            return 50
        case .info:
            return 80
        }
    }

}

//MARK: - Collection View Data Source

extension WeatherViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.collectionViewItemsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! WeatherByHourCollectionViewCell
        cell.data = dataSource?.collectionViewItem(indexPath: indexPath)
        return cell
    }
}

