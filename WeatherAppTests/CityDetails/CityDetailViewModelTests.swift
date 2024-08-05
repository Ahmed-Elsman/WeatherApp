//
//  CityDetailViewModelTests.swift
//  WeatherAppTests
//
//  Created by Ahmed Elsman on 05/08/2024.
//

import XCTest
@testable import WeatherApp

final class CityDetailViewModelTests: XCTestCase {
    var viewModel: CityDetailViewModel!
    var mockRepository: MockCityRepository!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockCityRepository()
        viewModel = CityDetailViewModel(cityName: "Vienna", cityRepository: mockRepository)
    }
    
    override func tearDown() {
        viewModel = nil
        mockRepository = nil
        super.tearDown()
    }
    
    func testFetchCityWeatherSuccess() async {
        let cityObjectData = DataLoader().loadJsonData(file: "city_object")!
        let city = try? JSONDecoder().decode(City.self, from: cityObjectData)
        
        let expectedCity = city
        mockRepository.mockCity = expectedCity
        
        let expectation = self.expectation(description: "Fetching city weather")
        
        DispatchQueue.global().async {
            Task {
                await self.viewModel.fetchCityWeather()
                expectation.fulfill()
            }
        }
        
        await fulfillment(of: [expectation], timeout: 2)
        
        XCTAssertEqual(viewModel.city?.name, expectedCity?.name)
        XCTAssertEqual(viewModel.city?.id, expectedCity?.id)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    func testFetchCityWeatherFailure() async {
            mockRepository.shouldThrowError = true
            
            let expectation = self.expectation(description: "Fetching city weather")
            
            DispatchQueue.global().async {
                Task {
                    await self.viewModel.fetchCityWeather()
                    expectation.fulfill()
                }
            }
            
            await fulfillment(of: [expectation], timeout: 2)
            
            XCTAssertNil(viewModel.city)
            XCTAssertNotNil(viewModel.errorMessage)
        }
}

