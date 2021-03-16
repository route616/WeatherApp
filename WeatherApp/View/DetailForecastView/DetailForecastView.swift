//
//  DetailForecastView.swift
//  WeatherApp
//
//  Created by Игорь on 03.03.2021.
//

import UIKit

@IBDesignable final class DetailForecastView: UIView {
    // MARK: - Outlets
    @IBOutlet weak var lowTemperatureLabel: UILabel!
    @IBOutlet weak var highTemperatureLabel: UILabel!
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
        guard let view = loadFromNib(nibName: "DetailForecastView") else { return }
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.register(
            UINib(nibName: "ConditionTableViewCell", bundle: nil),
            forCellReuseIdentifier: "conditionCell"
        )
        addSubview(view)
    }
}
