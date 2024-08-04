//
//  CitiesViewModel.swift
//  WeatherApp
//
//  Created by Ahmed Elsman on 04/08/2024.
//

import Combine

protocol CitiesViewModeling: ObservableObject {
    var cities: [CityDAO] { get }
    func addCity(name: String)
    func deleteCity(at index: Int)
    func fetchCities()
}

final class CitiesViewModel: ObservableObject, CitiesViewModeling {
    @Published private(set) var cities: [CityDAO] = []
    private var coreDataManager: CoreDataManaging

    init(coreDataManager: CoreDataManaging = CoreDataManager.shared) {
        self.coreDataManager = coreDataManager
        fetchCities()
    }

    func fetchCities() {
        cities = coreDataManager.fetchCities()
    }

    func addCity(name: String) {
        coreDataManager.addCity(name: name)
        fetchCities()
    }

    func deleteCity(at index: Int) {
        let city = cities[index]
        coreDataManager.deleteCity(city)
        fetchCities()
    }
}


