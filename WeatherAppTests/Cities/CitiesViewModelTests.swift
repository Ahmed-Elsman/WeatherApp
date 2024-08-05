//
//  CitiesViewModelTests.swift
//  WeatherAppTests
//
//  Created by Ahmed Elsman on 05/08/2024.
//

import XCTest
@testable import WeatherApp

class CitiesViewModelTests: XCTestCase {
    var viewModel: CitiesViewModel!
    var mockRepository: MockCityListRepository!

    override func setUp() {
        super.setUp()
        mockRepository = MockCityListRepository()
        viewModel = CitiesViewModel(cityListRepository: mockRepository)
    }

    override func tearDown() {
        viewModel = nil
        mockRepository = nil
        super.tearDown()
    }

    func testFetchCities() {
        let citiesObjectData = DataLoader().loadJsonData(file: "city_collection")!
        let cities = try? JSONDecoder().decode([City].self, from: citiesObjectData)
        
        if let mappedCities = cities?.map({ $0.toModel() }) {
            mockRepository.cities = mappedCities
            viewModel.fetchCities()
            XCTAssertEqual(viewModel.cities.count, 2)
            XCTAssertEqual(viewModel.cities[0].name, "Vienna")
            XCTAssertEqual(viewModel.cities[1].name, "Cairo")
        }
    }

    func testAddCity() {
        viewModel.addCity(name: "Vienna")
        XCTAssertEqual(viewModel.cities.count, 1)
        XCTAssertTrue(viewModel.cities.contains(where: {$0.name == "Vienna"}))
    }

    func testDeleteCity() {
        let citiesObjectData = DataLoader().loadJsonData(file: "city_collection")!
        let cities = try? JSONDecoder().decode([City].self, from: citiesObjectData)
        
        if let mappedCities = cities?.map({ $0.toModel() }) {
            mockRepository.cities = mappedCities
        }
        viewModel.fetchCities()
        viewModel.deleteCity(at: 0)
        XCTAssertEqual(viewModel.cities.count, 1)
        XCTAssertEqual(viewModel.cities[0].name, "Cairo")
    }

    func testIsCityAlreadyAdded() {
        let citiesObjectData = DataLoader().loadJsonData(file: "city_collection")!
        let cities = try? JSONDecoder().decode([City].self, from: citiesObjectData)
        
        if let mappedCities = cities?.map({ $0.toModel() }) {
            mockRepository.cities = mappedCities
            viewModel.fetchCities()
            XCTAssertTrue(viewModel.isCityAlreadyAdded(name: "Vienna"))
            XCTAssertFalse(viewModel.isCityAlreadyAdded(name: "Alex"))
        }
    }
}

