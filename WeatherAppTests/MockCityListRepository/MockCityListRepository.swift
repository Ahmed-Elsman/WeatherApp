//
//  MockCityListRepository.swift
//  WeatherAppTests
//
//  Created by Ahmed Elsman on 05/08/2024.
//

@testable import WeatherApp

class MockCityListRepository: CityListRepositoryProtocol {
    var cities: [CityDAO] = []

    func fetchCities() -> [CityDAO] {
        return cities
    }

    func addCity(name: String) {
        let cityObjectData = DataLoader().loadJsonData(file: "city_object")!
        let city = try? JSONDecoder().decode(City.self, from: cityObjectData)
        
        if let mappedCity = city?.toModel() {
            cities.append(mappedCity)
        }
    }

    func deleteCity(_ city: CityDAO) {
        cities.removeAll { $0.id == city.id }
    }

    func isCityAlreadyAdded(name: String) -> Bool {
        return cities.contains { $0.name == name }
    }
}
