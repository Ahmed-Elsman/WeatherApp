//
//  CitiesViewModel.swift
//  WeatherApp
//
//  Created by Ahmed Elsman on 04/08/2024.
//

final class CitiesViewModel: ObservableObject {
    @Published private(set) var cities: [CityDAO] = []
    private let cityListRepository: CityListRepositoryProtocol

    init(cityListRepository: CityListRepositoryProtocol) {
        self.cityListRepository = cityListRepository
    }

    func fetchCities() {
        cities.removeAll()
        cities = cityListRepository.fetchCities()
    }
    
    func setCities(_ cities: [CityDAO]) {
        self.cities = cities
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
