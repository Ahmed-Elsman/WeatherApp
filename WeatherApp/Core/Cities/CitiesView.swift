//
//  CitiesView.swift
//  WeatherApp
//
//  Created by Ahmed Elsman on 04/08/2024.
//

import SwiftUI

struct CitiesView: View {
    @StateObject var viewModel: CitiesViewModel

    var body: some View {
        NavigationView {
            List {
                ForEach(Array(viewModel.cities.enumerated()), id: \.element) { index, city in
                    Text(city.name ?? "")
                }
            }
            .navigationTitle("Cities")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}
