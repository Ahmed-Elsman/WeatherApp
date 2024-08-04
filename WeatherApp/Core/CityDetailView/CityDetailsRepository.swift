//
//  CityRepository.swift
//  WeatherApp
//
//  Created by Ahmed Elsman on 04/08/2024.
//

import Foundation
import Combine

protocol CityRepositoryProtocol {
    func fetchCityWeather(cityName: String) async throws -> City
}

final class CityDetailsRepository: CityRepositoryProtocol {
    private let networkManager: NetworkManaging
    
    init(networkManager: NetworkManaging = NetworkManager(session: nil)) {
        self.networkManager = networkManager
    }
    
    func fetchCityWeather(cityName: String) async throws -> City {
        let endpoint = CityWeatherDetailsEndpoint(cityName: cityName)
        let data: Data = try await networkManager.fetchData(from: endpoint.request)
        let cityResponse: City = try JSONDecoder().decode(City.self, from: data)
        return cityResponse
    }
}
