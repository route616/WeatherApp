//
//  DailyForecastView.swift
//  WeatherApp
//
//  Created by Игорь on 02.03.2021.
//

import UIKit

@IBDesignable class DailyForecastView: UIView {
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!

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
        guard let view = loadFromNib(nibName: "DailyForecastView") else { return }
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.register(
            UINib(nibName: "DailyTemperatureTableViewCell", bundle: nil),
            forCellReuseIdentifier: "dailyTemperatureCell"
        )
        addSubview(view)
    }
}
