//
//  CityDetailViewModel.swift
//  WeatherApp
//
//  Created by Ahmed Elsman on 04/08/2024.
//

import Foundation
import Combine

final class CityDetailViewModel: ObservableObject {
    @Published var city: City?
    @Published var errorMessage: String?
    private let cityRepository: CityRepositoryProtocol
    private let cityName: String
    
    init(cityName: String, cityRepository: CityRepositoryProtocol = CityDetailsRepository()) {
        self.cityName = cityName
        self.cityRepository = cityRepository
        Task {
            await fetchCityWeather()
        }
    }
    
    func fetchCityWeather() async {
        do {
            let city = try await cityRepository.fetchCityWeather(cityName: cityName)
            DispatchQueue.main.async {
                self.city = city
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
            }
        }
    }
}

