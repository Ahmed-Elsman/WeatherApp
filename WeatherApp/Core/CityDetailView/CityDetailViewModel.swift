//
//  CityDetailViewModel.swift
//  WeatherApp
//
//  Created by Ahmed Elsman on 04/08/2024.
//

import Foundation

final class CityDetailViewModel: ObservableObject {
    @Published var weather: WeatherDAO?
    @Published var city: City?
    @Published var errorMessage: String?
    private let cityRepository: CityRepositoryProtocol
    private let cityName: String

    init(cityName: String, weather: WeatherDAO? = nil, cityRepository: CityRepositoryProtocol = CityDetailsRepository()) {
        self.cityName = cityName
        self.cityRepository = cityRepository
        self.weather = weather
    }

    func fetchCityWeather() async {
        if weather?.city != nil {
            DispatchQueue.main.async { [weak self] in
                self?.city = self?.weather?.city?.toModel()
            }
            return
        }
        do {
            let city = try await cityRepository.fetchCityWeather(cityName: cityName)
            DispatchQueue.main.async { [weak self] in
                self?.city = city
            }
        } catch {
            DispatchQueue.main.async { [weak self] in
                self?.errorMessage = error.localizedDescription
            }
        }
    }
}
