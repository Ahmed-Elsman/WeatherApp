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
    private var cancellables = Set<AnyCancellable>()
    
    init(cityName: String, cityRepository: CityRepositoryProtocol = CityRepository()) {
        self.cityName = cityName
        self.cityRepository = cityRepository
        fetchCityWeather()
    }
    
    func fetchCityWeather() {
        cityRepository.fetchCityWeather(cityName: cityName)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            } receiveValue: { city in
                self.city = city
            }
            .store(in: &cancellables)
    }
}
