//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Игорь on 22.02.2021.
//

import UIKit

class WeatherViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var detailForecastView: DetailForecastView!

    private let conditionNames = [
        "💨  WIND", "💧  HUMIDITY", "💦  DEW POINT", "🪨  PRESSURE", "👁  VISIBILITY"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        detailForecastView.conditionTableView.delegate = self
        detailForecastView.conditionTableView.dataSource = self
    }
}

extension WeatherViewController: UITableViewDelegate {}

// MARK: - UITableViewDataSource
extension WeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conditionNames.count
    }
    
    func tableView(
        _ tableView: UITableView, cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = detailForecastView.conditionTableView
                .dequeueReusableCell(withIdentifier: "conditionCell") else {
            return UITableViewCell()
        }
        cell.textLabel?.text = conditionNames[indexPath.row]
        cell.detailTextLabel?.text = "\(indexPath.row)"
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return detailForecastView.conditionTableView.frame.height / 4.75
    }
}
