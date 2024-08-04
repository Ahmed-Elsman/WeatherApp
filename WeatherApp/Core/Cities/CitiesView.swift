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
                    CityCellView(viewModel: CityCellViewModel(city: city))
                }
            }
            .navigationTitle("Cities")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showAddCityAlert()
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }

    private func showAddCityAlert() {
        let alert = UIAlertController(title: "Add City", message: "Enter city name", preferredStyle: .alert)
        alert.addTextField()
        let addAction = UIAlertAction(title: "Add", style: .default) { _ in
            if let cityName = alert.textFields?.first?.text, !cityName.isEmpty {
                viewModel.addCity(name: cityName)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(addAction)
        alert.addAction(cancelAction)

        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first?.rootViewController {
            rootViewController.present(alert, animated: true)
        }
    }
}
