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
                // Action for info button
            }) {
                Image(systemName: "info.circle")
            }
        }
        .padding()
    }
}
