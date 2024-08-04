//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Ahmed Elsman on 04/08/2024.
//

import SwiftUI

@main
struct CitiesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            CitiesView(viewModel: CitiesViewModel())
                .environment(\.managedObjectContext, persistenceController.context)
        }
    }
}
