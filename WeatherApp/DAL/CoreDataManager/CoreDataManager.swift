//
//  CoreDataManager.swift
//  WeatherApp
//
//  Created by Ahmed Elsman on 04/08/2024.
//

import CoreData

protocol CoreDataManaging {
    func fetchCities() -> [CityDAO]
    func addCity(name: String)
    func deleteCity(_ city: CityDAO)
    func updateCity(with updatedCity: City)
}

class CoreDataManager: CoreDataManaging {
    static let shared = CoreDataManager()
    
    private init() {}
    
    var context: NSManagedObjectContext {
        return PersistenceController.shared.context
    }
    
    func fetchCities() -> [CityDAO] {
        let request: NSFetchRequest<CityDAO> = CityDAO.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            return []
        }
    }
    
    func addCity(name: String) {
        let city = CityDAO(context: context)
        city.name = name
        city.id = Int32(UUID().generateRandomInt())
        saveContext()
    }
    
    func updateCity(with updatedCity: City) {
        let fetchRequest: NSFetchRequest<CityDAO> = CityDAO.fetchRequest()
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "name == %@", updatedCity.name)
        
        do {
            let results = try context.fetch(fetchRequest)
            if let existingCity = results.first {
                
                // Update the existing city's properties
                existingCity.id = Int32(updatedCity.id)
                existingCity.base = updatedCity.base
                existingCity.visibility = Int32(updatedCity.visibility)
                
                if let coord = updatedCity.coord {
                    existingCity.coord = coord.toModel()
                    existingCity.coord?.city = existingCity
                }
                if let main = updatedCity.main {
                    existingCity.main = main.toModel()
                    existingCity.main?.city = existingCity
                }
                if let wind = updatedCity.wind {
                    existingCity.wind = wind.toModel()
                    existingCity.wind?.city = existingCity
                }
                
                // Append weather of updatedCity to existingCity weather
                if let weather = updatedCity.weather?.first {
                    let weatherCopy = WeatherDAO(context: context)
                    weatherCopy.id = Int32(weather.id)
                    weatherCopy.main = weather.main
                    weatherCopy.descriptions = weather.description
                    weatherCopy.icon = weather.icon
                    weatherCopy.city = existingCity
                    weatherCopy.dateTime = weather.dateTime ?? Date()
                    existingCity.addToWeather(weatherCopy)
                }
                saveContext()
            } else {
                print("City not found")
            }
        } catch {
            print("Failed to fetch city for updating: \(error)")
        }
    }
    
    func deleteCity(_ city: CityDAO) {
        context.delete(city)
        saveContext()
    }
    
    private func saveContext() {
        PersistenceController.shared.saveContext()
    }
}
