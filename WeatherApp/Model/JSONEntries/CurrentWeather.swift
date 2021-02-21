//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Игорь on 18.02.2021.
//

struct CurrentWeather: Codable {
    let dt: Int
    let sunrise: Int
    let sunset: Int

    let temp: Double
    let feelsLike: Double
    let pressure: Int
    let humidity: Int
    let dewPoint: Double

    let uvi: Double
    let clouds: Int
    let visibility: Int
    let windSpeed: Double
    let windDeg: Int
    let windGust: Double?

    let rain: MeasurableValue?
    let snow: MeasurableValue?

    let weather: [Weather]
}
