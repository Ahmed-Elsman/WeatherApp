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
        saveContext()
    }

    func deleteCity(_ city: CityDAO) {
        context.delete(city)
        saveContext()
    }

    private func saveContext() {
        PersistenceController.shared.saveContext()
    }
}
