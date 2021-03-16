//
//  String + capitalizeFirstLetter().swift
//  WeatherApp
//
//  Created by Игорь on 15.03.2021.
//

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
