//
//  CurrentWeatherView.swift
//  WeatherApp
//
//  Created by Игорь on 25.02.2021.
//

import UIKit

@IBDesignable class CurrentWeatherView: UIView {
    // MARK: - Inspectable properties
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }

    @IBInspectable var shadowRadius: CGFloat = 0 {
        didSet {
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowOpacity = 0.5
            self.layer.shadowOffset = CGSize(width: 0, height: shadowRadius)
            self.layer.shadowRadius = shadowRadius
        }
    }
}
