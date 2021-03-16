//
//  NetworkManager.swift
//  Weather
//
//  Created by Игорь on 28.12.2020.
//

import Foundation

class NetworkManager {
    // URL constants
    private let urlAPIKey = "bd3c55834d7fe525505536af28da7473"
    private let baseURL = "https://api.openweathermap.org/data/2.5"
    private var baseIconURL = "http://openweathermap.org/img/wn/"

    private var latitude: String
    private var longitude: String

    private var weatherURL: String {
        return baseURL + "/onecall?lat=" + latitude + "&lon=" + longitude + "&appid=" +
            urlAPIKey + "&exclude=minutely&units=metric&lang=ru"
    }

    init(with latitude: Double, and longitude: Double) {
        self.latitude = String(latitude)
        self.longitude = String(longitude)
    }

    func fetchWeather(
        onSuccess: @escaping (WeatherResponse) -> Void,
        onError: @escaping (String) -> Void
    ) {
        guard let weatherURL = URL(string: weatherURL) else {
            onError("Error building URL")
            return
        }

        let task = URLSession.shared.dataTask(with: weatherURL) { (data, response, error) in
            if let error = error {
                onError(error.localizedDescription)
                return
            }
            
            guard let data = data, let response = response as? HTTPURLResponse else {
                onError("Invalid data or response")
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                if response.statusCode == 200 {
                    let weather = try decoder.decode(WeatherResponse.self, from: data)
                    // TODO: - Implement fetching weather icon
                    DispatchQueue.main.async {
                        onSuccess(weather)
                    }
                } else {
                    onError("Response was not 200.")
                }
            } catch let DecodingError.dataCorrupted(context) {
                print(context)
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                print("error: ", error)
            }
        } // dataTask
        task.resume()
    } // fetchWeather
}
