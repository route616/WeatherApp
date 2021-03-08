//
//  ThumbTemperatureView.swift
//  WeatherApp
//
//  Created by Игорь on 05.03.2021.
//

import UIKit

@IBDesignable final class ThumbTemperatureView: UIView {
    // MARK: - Outlets
    @IBOutlet weak var temperatureValueLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = bounds.height / 2
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layer.cornerRadius = bounds.height / 2
    }
}
