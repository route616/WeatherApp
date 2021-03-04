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
    @IBOutlet weak var conditionTableView: UITableView!

    private let conditionCellID = "conditionCell"

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
        conditionTableView.register(
            UINib(nibName: "ConditionTableViewCell", bundle: nil),
            forCellReuseIdentifier: conditionCellID
        )
        addSubview(view)
    }
}
