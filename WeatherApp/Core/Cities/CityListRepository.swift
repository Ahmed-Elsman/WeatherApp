//
//  CityListRepository.swift
//  WeatherApp
//
//  Created by Ahmed Elsman on 04/08/2024.
//

import Foundation

protocol CityListRepositoryProtocol {
    func fetchCities() -> [CityDAO]
    func addCity(name: String)
    func deleteCity(_ city: CityDAO)
    func isCityAlreadyAdded(name: String) -> Bool
}

final class CityListRepository: CityListRepositoryProtocol {
     
    private var coreDataManager: CoreDataManaging

    init(coreDataManager: CoreDataManaging = CoreDataManager.shared) {
        self.coreDataManager = coreDataManager
    }

    func fetchCities() -> [CityDAO] {
        return coreDataManager.fetchCities()
    }

    func addCity(name: String) {
        if !isCityAlreadyAdded(name: name) {
            coreDataManager.addCity(name: name)
        }
    }

    func deleteCity(_ city: CityDAO) {
        coreDataManager.deleteCity(city)
    }

    func isCityAlreadyAdded(name: String) -> Bool {
        let cities = fetchCities()
        return cities.contains { $0.name == name }
    }
}
