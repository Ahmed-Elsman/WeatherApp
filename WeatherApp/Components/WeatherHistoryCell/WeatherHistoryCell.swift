//
//  WeatherHistoryCell.swift
//  WeatherApp
//
//  Created by Ahmed Elsman on 05/08/2024.
//

import SwiftUI

struct WeatherHistoryCell: View {
    @ObservedObject var viewModel: WeatherHistoryCellViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(viewModel.weather.dateTime?.dateTimeString() ?? "")
                .font(.caption)
            Text(viewModel.weather.descriptions ?? "")
                .font(.body)
        }

    }
}
