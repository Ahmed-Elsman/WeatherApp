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
                List(viewModel.weatherHistory) { weather in
                    WeatherHistoryCell(viewModel: WeatherHistoryCellViewModel(weather: weather))
                    .padding()
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
