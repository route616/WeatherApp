//
//  SplitViewController.swift
//  WeatherApp
//
//  Created by Игорь on 21.02.2021.
//

import UIKit

class SplitViewController: UISplitViewController {
    let networkManager = NetworkManager(withLatitude: 65.0, andLongitude: 38.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager.fetchWeather(onSuccess: onSuccess, onError: onError)
    }
    
    private func onSuccess(_ response: WeatherResponse) {
        if let alerts = response.alerts {
            print(alerts[1].description)
        } else {
            print("Нет оповещений")
        }
    }
    
    private func onError(_ errorDescription: String) {
        print(errorDescription)
    }
}
