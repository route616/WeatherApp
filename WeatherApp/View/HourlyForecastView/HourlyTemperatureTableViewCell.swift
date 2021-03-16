//
//  HourlyTemperatureTableViewCell.swift
//  WeatherApp
//
//  Created by Игорь on 05.03.2021.
//

import UIKit

@IBDesignable final class HourlyTemperatureTableViewCell: UITableViewCell {
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var temperatureProgressView: UIProgressView!
}
