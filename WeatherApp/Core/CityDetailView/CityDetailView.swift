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
        VStack(alignment: .leading, spacing: 16) {
            if let city = viewModel.city {
                Text(city.name)
                    .font(.largeTitle)
                    .padding(.bottom, 8)
                
                if let main = city.main {
                    Text("Temperature: \(main.temp, specifier: "%.2f")°C")
                    Text("Humidity: \(main.humidity)%")
                }
                
                if let wind = city.wind {
                    Text("Wind Speed: \(wind.speed, specifier: "%.2f") m/s")
                }
            } else {
                Text("Loading...")
            }
        }
        .padding()
        .onAppear {
            viewModel.fetchCityWeather()
        }
    }
}
