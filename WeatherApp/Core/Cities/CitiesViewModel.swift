//
//  CitiesViewModel.swift
//  WeatherApp
//
//  Created by Ahmed Elsman on 04/08/2024.
//

import Combine

final class CitiesViewModel: ObservableObject {
    @Published private(set) var cities: [CityDAO] = []
    private let cityListRepository: CityListRepositoryProtocol

    init(cityListRepository: CityListRepositoryProtocol) {
        self.cityListRepository = cityListRepository
    }

    func fetchCities() {
        cities = cityListRepository.fetchCities()
    }

    func addCity(name: String) {
        if !isCityAlreadyAdded(name: name) {
            cityListRepository.addCity(name: name)
            fetchCities()
        }
    }

    func deleteCity(at index: Int) {
        let city = cities[index]
        cityListRepository.deleteCity(city)
        fetchCities()
    }
    
    func isCityAlreadyAdded(name: String) -> Bool {
        return cities.contains { $0.name == name }
    }
}
