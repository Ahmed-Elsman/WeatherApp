//
//  CityRepository.swift
//  WeatherApp
//
//  Created by Ahmed Elsman on 04/08/2024.
//

import Foundation

protocol CityRepositoryProtocol {
    func fetchCityWeather(cityName: String) async throws -> City
}

final class CityDetailsRepository: CityRepositoryProtocol {
    private let networkManager: NetworkManaging
    private let coreDataManager: CoreDataManaging
    
    init(networkManager: NetworkManaging = NetworkManager(session: nil),
         coreDataManager: CoreDataManaging = CoreDataManager.shared) {
        self.networkManager = networkManager
        self.coreDataManager = coreDataManager
    }
    
    func fetchCityWeather(cityName: String) async throws -> City {
        let endpoint = CityWeatherDetailsEndpoint(cityName: cityName)
        let data: Data = try await networkManager.fetchData(from: endpoint.request)
        let cityResponse: City = try JSONDecoder().decode(City.self, from: data)
        coreDataManager.updateCity(with: cityResponse)
        return cityResponse
    }
}
