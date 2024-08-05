//
//  CitiesViewSnapshotTests.swift
//  WeatherAppTests
//
//  Created by Ahmed Elsman on 05/08/2024.
//

import XCTest
import SnapshotTesting
import SwiftUI
@testable import WeatherApp

class CitiesViewSnapshotTests: XCTestCase {
    var viewModel: CitiesViewModel!

    override func setUp() {
        super.setUp()
        // Initialize the view model with a mock repository
        let mockRepository = MockCityListRepository()
        viewModel = CitiesViewModel(cityListRepository: mockRepository)
    }

    func testCitiesViewWithNoCities() {
        // Set the view model's cities to an empty array
        viewModel.setCities([])

        // Create the view
        let citiesView = CitiesView(viewModel: self.viewModel)

        // Use SnapshotTesting to verify the view's appearance
        let viewController = UIHostingController(rootView: citiesView)
        assertSnapshot(of: viewController, as: .image)
    }

    func testCitiesViewWithCities() {
        let citiesObjectData = DataLoader().loadJsonData(file: "city_collection")!
        let cities = try? JSONDecoder().decode([City].self, from: citiesObjectData)

        if let mappedCities = cities?.map({ $0.toModel() }) {
            viewModel.setCities(mappedCities)
            
            // Create the view
            let citiesView = CitiesView(viewModel: self.viewModel)
            
            // Use SnapshotTesting to verify the view's appearance
            let viewController = UIHostingController(rootView: citiesView)
            assertSnapshot(of: viewController, as: .image)
        }
    }
}

