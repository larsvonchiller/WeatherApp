//
//  UIViewController+AddAlert.swift
//  WeatherClient
//
//  Created by Matoshko Andrey on 5/16/20.
//  Copyright © 2020 Matoshko Andrey. All rights reserved.
//

import UIKit

extension UIViewController {
    func addAlert(title: String? = nil, message: String? = nil, actions: [UIAlertAction]? = nil) {
        var actionsArray = [UIAlertAction]()
        
        if let newActions = actions {
            actionsArray = newActions
        } else {
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            actionsArray.append(okAction)
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in actionsArray {
            alert.addAction(action)
        }
        present(alert, animated: true)
    }
}
