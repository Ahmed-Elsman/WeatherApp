//
//  WeatherHistoryViewModelTests.swift
//  WeatherAppTests
//
//  Created by Ahmed Elsman on 05/08/2024.
//

import XCTest
@testable import WeatherApp

final class WeatherHistoryViewModelTests: XCTestCase {
    var viewModel: WeatherHistoryViewModel!
    var mockCity: CityDAO!

    override func setUp() {
        super.setUp()

        mockCity = CityDAO(context: PersistenceController.shared.container.viewContext)
        mockCity.name = "TestCity"

        let weather1 = WeatherDAO(context: PersistenceController.shared.container.viewContext)
        weather1.dateTime = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        weather1.descriptions = "Sunny"

        let weather2 = WeatherDAO(context: PersistenceController.shared.container.viewContext)
        weather2.dateTime = Calendar.current.date(byAdding: .day, value: -2, to: Date())
        weather2.descriptions = "Cloudy"

        mockCity.weather = NSSet(array: [weather1, weather2])

        viewModel = WeatherHistoryViewModel(city: mockCity)
    }

    override func tearDown() {
        viewModel = nil
        mockCity = nil
        super.tearDown()
    }

    func testFetchWeatherHistory() {
        viewModel.fetchWeatherHistory()

        XCTAssertEqual(viewModel.weatherHistory.count, 2)
        XCTAssertEqual(viewModel.weatherHistory[0].descriptions, "Sunny")
        XCTAssertEqual(viewModel.weatherHistory[1].descriptions, "Cloudy")
    }

    func testCityNameInitialization() {
        XCTAssertEqual(viewModel.cityName, "TestCity")
    }

    func testWeatherHistorySorting() {
        viewModel.fetchWeatherHistory()

        XCTAssertTrue(viewModel.weatherHistory[0].dateTime! > viewModel.weatherHistory[1].dateTime!)
    }
}
