//
//  JSONEntries.swift
//  Weather
//
//  Created by Игорь on 28.12.2020.
//

struct WeatherResponse: Codable {
    let lat: Double
    let lon: Double
    let timezone: String
    let timezoneOffset: Int

    let current: CurrentWeather
    let hourly: [HourlyWeather]
    let daily: [DailyWeather]

    let alerts: [Alert]?
}
