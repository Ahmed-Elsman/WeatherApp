//
//  CityCellViewModel.swift
//  WeatherApp
//
//  Created by Ahmed Elsman on 04/08/2024.
//

import Foundation

class CityCellViewModel: ObservableObject {
    let cityName: String

    init(city: City) {
        self.cityName = city.name ?? ""
    }
}
