//
//  HourlyWeather.swift
//  WeatherApp
//
//  Created by Игорь on 21.02.2021.
//

struct HourlyWeather: Codable {
    let dt: Int

    let temp: Double
    let feelsLike: Double

    let pressure: Int
    let humidity: Int
    let dewPoint: Double

    let uvi: Double
    let clouds: Int
    let visibility: Int

    let windSpeed: Double
    let windGust: Double?
    let windDeg: Int

    let pop: Double
    let rain: MeasurableValue?
    let snow: MeasurableValue?

    let weather: [Weather]
}
