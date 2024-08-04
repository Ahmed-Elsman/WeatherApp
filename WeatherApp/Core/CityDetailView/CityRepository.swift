//
//  CityRepository.swift
//  WeatherApp
//
//  Created by Ahmed Elsman on 04/08/2024.
//
/*
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
        let endpoint = CityWeatherDetailsEndpoint(cityName: cityName)
        
        return Future<City, Error> { promise in
            self.networkManager.fetchData(from: endpoint) { (result: Result<City, Error>) in
                switch result {
                case .success(let city):
                    print("Save please")
                    promise(.success(city))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
*/


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
        let endpoint = CityWeatherDetailsEndpoint(cityName: cityName)
        
        return Future<City, Error> { promise in
            self.networkManager.fetchData(from: endpoint.request) { result, error in
                if let error = error {
                    promise(.failure(error))
                    return
                }
                guard let result = result else {
                    promise(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data"])))
                    return
                }
                do {
                    let city = try JSONDecoder().decode(City.self, from: result as! Data)
                    promise(.success(city))
                } catch {
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
}
