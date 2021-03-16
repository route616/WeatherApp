//
//  DailyTemperatureTableViewCell.swift
//  WeatherApp
//
//  Created by Игорь on 12.03.2021.
//

import UIKit

@IBDesignable final class DailyTemperatureTableViewCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var dayOfWeekLabel: UILabel!
    @IBOutlet weak var weatherIconImage: UIImageView!
    @IBOutlet weak var lowTemperatureLabel: UILabel!
    @IBOutlet weak var highTemperatureLabel: UILabel!
}
