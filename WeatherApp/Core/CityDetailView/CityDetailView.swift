//
//  CityDetailView.swift
//  WeatherApp
//
//  Created by Ahmed Elsman on 04/08/2024.
//

import SwiftUI

struct CityDetailView: View {
    @ObservedObject var viewModel: CityDetailViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: UIConstants.containerViewPadding) {
                if let city = viewModel.city {
                    if let weather = city.weather?.first {
                        weatherSection(weather)
                    }
                    
                    Divider()
                    
                    weatherDetailsSection(city)
                        .padding(.top, UIConstants.containerViewPadding)
                }
            }
            .padding()
            .navigationTitle(viewModel.city?.name ?? "")
        }
        .task {
            await viewModel.fetchCityWeather()
        }
    }
    
    private func weatherDetailsSection(_ city: City) -> some View {
        VStack(alignment: .leading, spacing: UIConstants.containerViewSpacing) {
            
            temperatureSection(city)
            
            humiditySection(city)
            
            if let wind = city.wind {
                windSection(wind)
            }
        }
    }
    
    private func weatherSection(_ weather: Weather) -> some View {
        VStack(alignment: .leading, spacing: UIConstants.containerViewSpacing) {
            Text((weather.dateTime ?? Date()).dateTimeString())
                .font(.caption)
                .foregroundColor(.secondary)
            
            Text(weather.description)
                .font(.title)
                .fontWeight(.medium)
                .foregroundColor(.primary)
        }
        
    }
    
    private func temperatureSection(_ city: City) -> some View {
        HStack {
            Text("Temperature:")
                .font(.headline)
                .foregroundColor(.secondary)
            Spacer()
            Text("\(city.main?.tempCelsius ?? 0.0, specifier: "%.2f")°C")
                .font(.title2)
                .foregroundColor(.primary)
        }
    }
    
    private func humiditySection(_ city: City) -> some View {
        HStack {
            Text("Humidity:")
                .font(.headline)
                .foregroundColor(.secondary)
            Spacer()
            Text("\(city.main?.humidity ?? 0)%")
                .font(.title2)
                .foregroundColor(.primary)
        }
    }
    
    private func windSection(_ wind: Wind) -> some View {
        HStack {
            Text("Wind Speed:")
                .font(.headline)
                .foregroundColor(.secondary)
            Spacer()
            Text("\(wind.speed, specifier: "%.2f") m/s")
                .font(.title2)
                .foregroundColor(.primary)
        }
    }
}
