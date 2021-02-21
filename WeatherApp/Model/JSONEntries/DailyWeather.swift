//
//  DailyWeather.swift
//  WeatherApp
//
//  Created by Игорь on 18.02.2021.
//

struct DailyWeather: Codable {
    let dt: Int
    let sunrise: Int
    let sunset: Int

    let temp: Temperature
    let feelsLike: FeelsLikeTemperature

    let pressure: Int
    let humidity: Int
    let dewPoint: Double
    let windSpeed: Double
    let windGust: Double?
    let windDeg: Int

    let clouds: Int
    let uvi: Double

    let pop: Double
    let rain: Double?
    let snow: Double?

    let weather: [Weather]
}

struct Temperature: Codable {
    let morn: Double
    let day: Double
    let eve: Double
    let night: Double
    let min: Double
    let max: Double
}

struct FeelsLikeTemperature: Codable {
    let day: Double
    let night: Double
    let eve: Double
    let morn: Double
}
