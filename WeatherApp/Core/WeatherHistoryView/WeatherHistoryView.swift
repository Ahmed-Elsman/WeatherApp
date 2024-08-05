//
//  WeatherHistoryView.swift
//  WeatherApp
//
//  Created by Ahmed Elsman on 05/08/2024.
//

import SwiftUI

struct WeatherHistoryView: View {
    @ObservedObject var viewModel: WeatherHistoryViewModel
    
    var body: some View {
        List(viewModel.weatherHistory) { weather in
            HStack {
                Text(weather.dateTime?.dateTimeString() ?? "")
                    .font(.caption)
                Spacer()
                Text(weather.descriptions ?? "")
                    .font(.body)
            }
            .padding()
        }
        .navigationTitle(viewModel.cityName)
        .onAppear {
            viewModel.fetchWeatherHistory()
        }
    }
}
