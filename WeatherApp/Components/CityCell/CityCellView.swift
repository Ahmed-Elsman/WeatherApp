//
//  CityCellView.swift
//  WeatherApp
//
//  Created by Ahmed Elsman on 04/08/2024.
//

import SwiftUI

struct CityCellView: View {
    @ObservedObject var viewModel: CityCellViewModel

    var body: some View {
        HStack {
            Text(viewModel.cityName)
            Spacer()
            Button(action: {
                viewModel.showingWeatherHistory.toggle()
            }) {
                Image(systemName: "info.circle")
            }
            .sheet(isPresented: $viewModel.showingWeatherHistory) {
                WeatherHistoryView(viewModel: WeatherHistoryViewModel(city: viewModel.city))
            }
        }
        .padding()
    }
}
