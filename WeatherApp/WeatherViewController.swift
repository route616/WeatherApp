//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Игорь on 22.02.2021.
//

import UIKit

class WeatherViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var currentWeatherView: CurrentWeatherView!
    @IBOutlet weak var detailForecastView: DetailForecastView!
    @IBOutlet weak var hourlyForecastView: HourlyForecastView!
    @IBOutlet weak var dailyForecastView: DailyForecastView!

    private let conditionNames = [
        "💨  WIND", "💧  HUMIDITY", "💦  DEW POINT", "🪨  PRESSURE", "👁  VISIBILITY"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        detailForecastView.conditionTableView.delegate = self
        detailForecastView.conditionTableView.dataSource = self
        hourlyForecastView.hourlyForecastTableView.delegate = self
        hourlyForecastView.hourlyForecastTableView.dataSource = self
    }
}

// MARK: - UITableViewDelegate
extension WeatherViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return detailForecastView.conditionTableView.frame.height / 4.75
    }
}

// MARK: - UITableViewDataSource
extension WeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == detailForecastView.conditionTableView {
            return conditionNames.count
        } else if tableView == hourlyForecastView.hourlyForecastTableView {
            return 2
        } else {
            return 0
        }
    }
    
    func tableView(
        _ tableView: UITableView, cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = detailForecastView.conditionTableView
                .dequeueReusableCell(withIdentifier: "conditionCell") as? ConditionTableViewCell
        else {
            return UITableViewCell()
        }
        cell.conditionNameLabel?.text = conditionNames[indexPath.row]
        cell.conditionValueLabel?.text = "\(indexPath.row)"
        return cell
    }
}
