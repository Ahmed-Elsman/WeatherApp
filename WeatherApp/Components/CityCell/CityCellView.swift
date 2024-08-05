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
            ZStack {
                Button(action: {
                    viewModel.showingWeatherHistory = true
                }) {
                    Image(systemName: "info.circle")
                }
                .buttonStyle(PlainButtonStyle())
            }
            .fullScreenCover(isPresented: $viewModel.showingWeatherHistory) {
                WeatherHistoryView(
                    viewModel: WeatherHistoryViewModel(
                        city: viewModel.city
                    ),
                    isPresented: $viewModel.showingWeatherHistory
                )
            }
        }
        .padding()
    }
}
