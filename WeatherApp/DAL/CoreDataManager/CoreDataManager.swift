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
        fetchRequest.predicate = NSPredicate(format: "name ==[cd] %@", updatedCity.name ?? "")
        
        do {
            let results = try context.fetch(fetchRequest)
            if let existingCity = results.first {
                existingCity.name = updatedCity.name
                saveContext()
            }
        } catch {
            // TODO: need to show an alert if there exist an error happens when updating data
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
