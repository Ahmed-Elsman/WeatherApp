//
//  WeatherHistoryViewModel.swift
//  WeatherApp
//
//  Created by Ahmed Elsman on 05/08/2024.
//

import Foundation

class WeatherHistoryCellViewModel: ObservableObject {
    @Published var weather: WeatherDAO

    init(weather: WeatherDAO) {
        self.weather = weather
    }
}
