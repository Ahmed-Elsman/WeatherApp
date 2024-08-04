//
//  CityRepository.swift
//  WeatherApp
//
//  Created by Ahmed Elsman on 04/08/2024.
//

import Foundation
import Combine

protocol CityRepositoryProtocol {
    func fetchCityWeather(cityName: String) -> AnyPublisher<City, Error>
}

final class CityRepository: CityRepositoryProtocol {
    private let networkManager: NetworkManaging
    
    init(networkManager: NetworkManaging = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func fetchCityWeather(cityName: String) -> AnyPublisher<City, Error> {
        let endpoint = CityWeatherDetailsEndpoint.init(cityName: cityName)
        
        return Future<City, Error> { promise in
            self.networkManager.fetchData(from: endpoint) { (result: Result<City, Error>) in
                switch result {
                case .success(let city):
//                    self.saveThisRequestFunc()
                    print("Save please")
                    promise(.success(city))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
}
