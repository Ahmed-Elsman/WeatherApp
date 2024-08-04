//
//  CitiesViewModel.swift
//  WeatherApp
//
//  Created by Ahmed Elsman on 04/08/2024.
//

import Combine

protocol CitiesViewModeling: ObservableObject {
    var cities: [City] { get }
}

class CitiesViewModel: ObservableObject, CitiesViewModeling {
    @Published private(set) var cities: [City] = []

    init() {
        fetchCities()
    }

    func fetchCities() {
        cities = []
    }
}


