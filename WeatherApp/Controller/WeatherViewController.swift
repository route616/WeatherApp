//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Игорь on 22.02.2021.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var currentWeatherView: CurrentWeatherView!
    @IBOutlet weak var detailForecastView: DetailForecastView!
    @IBOutlet weak var hourlyForecastView: HourlyForecastView!
    @IBOutlet weak var dailyForecastView: DailyForecastView!
    @IBOutlet weak var currentBottomViewControl: UISegmentedControl!

    private var bottomViewArray = [UIView]()
    private var conditions = [
        "💨  WIND": "",
        "💧  HUMIDITY": "",
        "💦  DEW POINT": "",
        "🪨  PRESSURE": "",
        "👁  VISIBILITY": ""
    ]

    private var conditionNames: [String] {
        return [String](conditions.keys)
    }
    private var conditionValues: [String] {
        return [String](conditions.values)
    }

    private var hourlyTemperature = [Double]()

    private let locationManager = CLLocationManager()
    private var networkManager: NetworkManager?
    private var weatherData: WeatherResponse? {
        didSet {
            guard let weatherData = weatherData else { return }
            let currentWeatherIcon = weatherData.current.weather.last?.icon ?? ""

            // Present currentWeatherView data
            currentWeatherView.temperatureLabel.text = "\(Int(weatherData.current.temp))℃"
            currentWeatherView.feelsLikeLabel.text = "\(Int(weatherData.current.feelsLike))℃"
            currentWeatherView.descriptionLabel
                .text = weatherData.current.weather.last?.description.capitalizingFirstLetter()
            currentWeatherView.weatherIconImage.image = UIImage(named: currentWeatherIcon)

            // Present detailForecastView data
            if let first = weatherData.daily.first {
                detailForecastView.lowTemperatureLabel.text = "\(Int(first.temp.min))℃"
                detailForecastView.highTemperatureLabel.text = "\(Int(first.temp.max))℃"
            } else {
                detailForecastView.lowTemperatureLabel.text = "--℃"
                detailForecastView.highTemperatureLabel.text = "--℃"
            }
            conditions["💨  WIND"] = "\(Int(weatherData.current.windSpeed)) m/s"
            conditions["💧  HUMIDITY"] = "\(weatherData.current.humidity) %"
            conditions["💦  DEW POINT"] = "\(Int(weatherData.current.dewPoint))℃"
            conditions["🪨  PRESSURE"] = "\(weatherData.current.pressure) hPa"
            conditions["👁  VISIBILITY"] =
                "\((Double(weatherData.current.visibility) / 1000).rounded()) km"

            // Present hourlyForecastView data
            for hourlyCondition in weatherData.hourly {
                hourlyTemperature.append(hourlyCondition.temp)
            }
            
        }
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        bottomViewArray.append(detailForecastView)
        bottomViewArray.append(hourlyForecastView)
        bottomViewArray.append(dailyForecastView)

        // UITableView delegation
        detailForecastView.tableView.delegate = self
        detailForecastView.tableView.dataSource = self
        hourlyForecastView.tableView.delegate = self
        hourlyForecastView.tableView.dataSource = self
        dailyForecastView.tableView.delegate = self
        dailyForecastView.tableView.dataSource = self

        // CLLocationManager delegation
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    private func onSuccess(weatherResponse: WeatherResponse) {
        weatherData = weatherResponse
        detailForecastView.tableView.reloadData()
        hourlyForecastView.tableView.reloadData()
        dailyForecastView.tableView.reloadData()
    }

    private func onError(error: String) {
        // TODO: - Implement alert
        print(error)
    }

    // MARK: - Actions
    @IBAction func bottomViewChanged(_ sender: UISegmentedControl) {
        bottomViewArray.forEach { (view) in
            view.isHidden = true
        }
        bottomViewArray[sender.selectedSegmentIndex].isHidden = false
    }
}

// MARK: - UITableViewDelegate
extension WeatherViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == detailForecastView.tableView {
            return tableView.frame.height / 4.75
        } else {
            return 44
        }
    }
}

// MARK: - UITableViewDataSource
extension WeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let weatherData = weatherData else { return 0 }
        switch tableView {
        case detailForecastView.tableView:
            return conditions.count
        case hourlyForecastView.tableView:
            return weatherData.hourly.count
        case dailyForecastView.tableView:
            return weatherData.daily.count
        default:
            return 0
        }
    }

    func tableView(
        _ tableView: UITableView, cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let weatherData = weatherData else { return UITableViewCell() }

        switch tableView {
        case detailForecastView.tableView:
            guard let cell = detailForecastView.tableView
                    .dequeueReusableCell(withIdentifier: "conditionCell")
            as? ConditionTableViewCell else {
                return UITableViewCell()
            }
            cell.conditionNameLabel?.text = conditionNames[indexPath.row]
            cell.conditionValueLabel?.text = conditionValues[indexPath.row]
            return cell

        case hourlyForecastView.tableView:
            guard let cell = hourlyForecastView.tableView
                    .dequeueReusableCell(withIdentifier: "hourlyTemperatureCell")
            as? HourlyTemperatureTableViewCell else {
                return UITableViewCell()
            }

            let dateFormatter = DateFormatter()
            let currentHour = Date(
                timeIntervalSince1970: TimeInterval(weatherData.hourly[indexPath.row].dt)
            )
            let minTemp = hourlyTemperature.min() ?? 0.0
            let maxTemp = hourlyTemperature.max() ?? 0.0
            let tempRange = maxTemp - minTemp

            dateFormatter.dateFormat = "h a"

            if indexPath.row == 0 {
                cell.hourLabel.text = "NOW"
            } else {
                cell.hourLabel.text = dateFormatter.string(from: currentHour)
            }
            cell.temperatureLabel.text = "\(Int(hourlyTemperature[indexPath.row]))º"
            cell.temperatureProgressView.setProgress(
                Float((hourlyTemperature[indexPath.row] - minTemp) / tempRange),
                animated: false
            )

            return cell

        case dailyForecastView.tableView:
            guard let cell = dailyForecastView.tableView
                    .dequeueReusableCell(withIdentifier: "dailyTemperatureCell")
            as? DailyTemperatureTableViewCell else {
                return UITableViewCell()
            }
            let dailyWeatherIcon = weatherData.daily[indexPath.row].weather.last?.icon ?? ""

            let dateFormatter = DateFormatter()
            let currentDay = Date(
                timeIntervalSince1970: TimeInterval(weatherData.daily[indexPath.row].dt)
            )

            dateFormatter.dateFormat = "EEEE"

            if indexPath.row == 0 {
                cell.dayOfWeekLabel.text = "Today"
            } else {
                cell.dayOfWeekLabel.text = dateFormatter.string(from: currentDay)
            }
            cell.weatherIconImage.image = UIImage(named: dailyWeatherIcon)
            cell.highTemperatureLabel.text = "\(Int(weatherData.daily[indexPath.row].temp.max))º"
            cell.lowTemperatureLabel.text = "\(Int(weatherData.daily[indexPath.row].temp.min))º"

            return cell

        default:
            return UITableViewCell()
        } // switch tableView
    } // tableView()
}

// MARK: - CLLocationManagerDelegate
extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(
        _ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]
    ) {
        guard let location = locations.first else { return }
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        networkManager = NetworkManager(with: latitude, and: longitude)
        networkManager?.fetchWeather(onSuccess: onSuccess, onError: onError)
    }
}
