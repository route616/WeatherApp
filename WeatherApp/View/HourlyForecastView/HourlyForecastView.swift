//
//  HourlyForecastView.swift
//  WeatherApp
//
//  Created by Игорь on 02.03.2021.
//

import UIKit

@IBDesignable final class HourlyForecastView: UIView {
    // MARK: - Outlets
    @IBOutlet weak var hourlyForecastTableView: UITableView!

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }

    // MARK: - configure()
    private func configureView() {
        guard let view = loadFromNib(nibName: "HourlyForecastView") else { return }
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        hourlyForecastTableView.register(
            UINib(nibName: "HourlyTemperatureTableViewCell", bundle: nil),
            forCellReuseIdentifier: "hourlyTemperatureCell"
        )
        addSubview(view)
    }
}
