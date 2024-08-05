//
//  WeatherHistoryViewModel.swift
//  WeatherApp
//
//  Created by Ahmed Elsman on 05/08/2024.
//

import Foundation

class WeatherHistoryViewModel: ObservableObject {
    @Published var weatherHistory: [WeatherDAO] = []
    let cityName: String
    private let city: CityDAO

    init(city: CityDAO) {
        self.cityName = city.name ?? "City Name"
        self.city = city
    }

    func fetchWeatherHistory() {
        if let weatherSet = city.weather as? Set<WeatherDAO> {
            self.weatherHistory = Array(weatherSet).sorted(by: { $0.dateTime ?? Date() > $1.dateTime ?? Date() })
        }
    }
}
