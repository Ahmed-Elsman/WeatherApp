//
//  CoreDataManager.swift
//  WeatherApp
//
//  Created by Ahmed Elsman on 04/08/2024.
//

import CoreData

protocol CoreDataManaging {
    func fetchCities() -> [City]
}

class CoreDataManager: CoreDataManaging {
    static let shared = CoreDataManager()

    private init() {}

    private var context: NSManagedObjectContext {
        return PersistenceController.shared.context
    }

    func fetchCities() -> [City] {
        let request: NSFetchRequest<City> = City.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            return []
        }
    }
}
