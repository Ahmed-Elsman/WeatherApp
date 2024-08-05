//
//  MockCityRepository.swift
//  WeatherAppTests
//
//  Created by Ahmed Elsman on 05/08/2024.
//

@testable import WeatherApp

class MockCityRepository: CityRepositoryProtocol {
    var mockCity: City?
    var shouldThrowError = false

    func fetchCityWeather(cityName: String) async throws -> City {
        if shouldThrowError {
            throw NSError(domain: "TestError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Test error message"])
        }
        return mockCity!
    }
}
