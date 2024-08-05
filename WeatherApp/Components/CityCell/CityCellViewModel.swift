//
//  CityCellViewModel.swift
//  WeatherApp
//
//  Created by Ahmed Elsman on 04/08/2024.
//

import Foundation

class CityCellViewModel: ObservableObject {
    @Published var city: CityDAO
    @Published var showingWeatherHistory = false

    var cityName: String {
        return city.name ?? ""
    }
    
    init(city: CityDAO) {
        self.city = city
    }
}
