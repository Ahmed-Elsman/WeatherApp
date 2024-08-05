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
            citiesList()
            .navigationTitle("Cities")
            .navigationBarItems(trailing: Button(action: {
                showAddCityAlert()
            }) {
                Image(systemName: "plus")
            })
            .onAppear {
                viewModel.fetchCities()
            }
        }
    }
    
    private func citiesList() -> some View {
        List {
            ForEach(Array(viewModel.cities.enumerated()), id: \.element.name) { index, city in
                NavigationLink(destination: CityDetailView(viewModel: CityDetailViewModel(cityName: city.name ?? ""))) {
                    cityCell(index, city)
                }
            }
        }
    }
    
    private func cityCell(_ index: Int, _ city: CityDAO) -> some View {
        CityCellView(viewModel: CityCellViewModel(city: city))
            .swipeActions {
                Button(role: .destructive) {
                    viewModel.deleteCity(at: index)
                } label: {
                    Label("Delete", systemImage: "trash")
                }
            }
            .buttonStyle(PlainButtonStyle())
    }
    
    private func showAddCityAlert() {
        let alertController = UIAlertController(title: "Add City", message: "Enter city name", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "City Name"
        }
        let addAction = UIAlertAction.createAddAction(textField: alertController.textFields?.first, viewModel: viewModel) {
            viewModel.fetchCities()
        }
        let cancelAction = UIAlertAction.createCancelAction()
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
    
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first?.rootViewController {
            rootViewController.present(alertController, animated: true)
        }
    }
}
