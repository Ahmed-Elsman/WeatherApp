//
//  CoreDataManagerTests.swift
//  WeatherAppTests
//
//  Created by Ahmed Elsman on 05/08/2024.
//

import XCTest
import CoreData
@testable import WeatherApp

final class CoreDataManagerTests: XCTestCase {
    var coreDataManager: CoreDataManager!
    var context: NSManagedObjectContext!
    
    override func setUp() {
        super.setUp()
        
        coreDataManager = CoreDataManager.shared
        context = PersistenceController.shared.context
        clearData()
    }
    
    override func tearDown() {
        clearData()
        coreDataManager = nil
        context = nil
        super.tearDown()
    }
    
    private func clearData() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = CityDAO.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            XCTFail("Failed to clear data: \(error)")
        }
        
    }
    
    func testFetchCities() {
        // Given
        let cityName = "TestCity"
        coreDataManager.addCity(name: cityName)
        
        // When
        let cities = coreDataManager.fetchCities()
        
        // Then
        XCTAssertEqual(cities.count, 1)
        XCTAssertEqual(cities.first?.name, cityName)
    }
    
    func testAddCity() {
        // Given
        let cityName = "NewCity"
        
        // When
        coreDataManager.addCity(name: cityName)
        let cities = coreDataManager.fetchCities()
        
        // Then
        XCTAssertEqual(cities.count, 1)
        XCTAssertEqual(cities.first?.name, cityName)
    }
    
    func testDeleteCity() {
        // Given
        let cityName = "CityToDelete"
        coreDataManager.addCity(name: cityName)
        let cities = coreDataManager.fetchCities()
        XCTAssertEqual(cities.count, 1)
        
        // When
        if let city = cities.first {
            coreDataManager.deleteCity(city)
        }
        let updatedCities = coreDataManager.fetchCities()
        
        // Then
        XCTAssertEqual(updatedCities.count, 0)
    }
    
    func testUpdateCity() {
        // Given
        let cityName = "CityToUpdate"
        coreDataManager.addCity(name: cityName)
        var cities = coreDataManager.fetchCities()
        XCTAssertEqual(cities.count, 1)
        XCTAssertEqual(cities.first?.name, cityName)
        
        // Create updated City object
        let cityObjectData = DataLoader().loadJsonData(file: "city_object")!
        if let updatedCity = try? JSONDecoder().decode(City.self, from: cityObjectData) {
            // When
            coreDataManager.updateCity(with: updatedCity)
            cities = coreDataManager.fetchCities()
            
            // Then
            XCTAssertEqual(cities.count, 1)
            XCTAssertEqual(cities.first?.name, cityName)
        }
    }
}

