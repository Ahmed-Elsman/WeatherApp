//
//  WeatherHistoryView.swift
//  WeatherApp
//
//  Created by Ahmed Elsman on 05/08/2024.
//

import SwiftUI

struct WeatherHistoryView: View {
    @ObservedObject var viewModel: WeatherHistoryViewModel
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.weatherHistory, id: \.dateTime) { weather in
                    NavigationLink(destination: CityDetailView(viewModel: CityDetailViewModel(cityName: weather.city?.name ?? "", weather: weather))) {
                        WeatherHistoryCell(viewModel: WeatherHistoryCellViewModel(weather: weather))
                    }
                }
                .navigationTitle(viewModel.cityName)
            }
            .navigationBarItems(leading: Button("Done") {
                isPresented = false
            })
            .onAppear {
                viewModel.fetchWeatherHistory()
            }
        }
    }
}

