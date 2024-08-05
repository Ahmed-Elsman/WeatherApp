//
//  CityDetailViewSnapshotTests.swift
//  WeatherAppTests
//
//  Created by Ahmed Elsman on 05/08/2024.
//

import XCTest
import SnapshotTesting
import SwiftUI
@testable import WeatherApp

class CityDetailViewSnapshotTests: XCTestCase {
    var viewModel: CityDetailViewModel!

    override func setUp() {
        super.setUp()
        // Initialize the view model with a mock repository
        viewModel = CityDetailViewModel(cityName: "Vienna", cityRepository: MockCityDetailsRepository())
    }

    func testCityDetailViewWithWeatherData() {
        // Arrange: Set up the mock data
        let cityObjectData = DataLoader().loadJsonData(file: "city_object")!
        let mockCity = try? JSONDecoder().decode(City.self, from: cityObjectData)

        viewModel.city = mockCity

        // Create the view
        let cityDetailView = CityDetailView(viewModel: self.viewModel)

        // Use SnapshotTesting to verify the view's appearance
        let viewController = UIHostingController(rootView: cityDetailView)
        // Wait for 3 seconds before asserting the snapshot
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            assertSnapshot(of: viewController, as: .image)
        }
    }

    func testCityDetailViewWithoutWeatherData() {
        // Arrange: Initialize the view model without weather data
        viewModel.weather = nil
        viewModel.city = nil

        // Create the view
        let cityDetailView = CityDetailView(viewModel: self.viewModel)

        // Use SnapshotTesting to verify the view's appearance
        let viewController = UIHostingController(rootView: cityDetailView)
        assertSnapshot(of: viewController, as: .image)
    }
}
