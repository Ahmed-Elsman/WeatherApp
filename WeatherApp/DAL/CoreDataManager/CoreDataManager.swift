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
    func updateCity(with updatedCity: CityDAO)
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
    
    func updateCity(with updatedCity: CityDAO) {
        let fetchRequest: NSFetchRequest<CityDAO> = CityDAO.fetchRequest()
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "id == %d", updatedCity.id)

        do {
            let results = try context.fetch(fetchRequest)
            if let existingCity = results.first {
                // Update the existing city's properties
                existingCity.name = updatedCity.name
                
                // Fetch the old city to delete if necessary
                let oldFetchRequest: NSFetchRequest<CityDAO> = CityDAO.fetchRequest()
                oldFetchRequest.predicate = NSPredicate(format: "id != %d AND name == %@", updatedCity.id, updatedCity.name ?? "")
                let oldResults = try context.fetch(oldFetchRequest)
                for oldCity in oldResults {
                    context.delete(oldCity)
                }
                
                saveContext()
            } else {
                print("City not found")
            }
        } catch {
            // TODO: Show an alert if there is an error when fetching or updating data
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
