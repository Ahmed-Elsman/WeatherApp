//
//  CityModel.swift
//  WeatherApp
//
//  Created by Ahmed Elsman on 04/08/2024.
//

import Foundation
import CoreData

struct City: Codable {
    let coord: Coord?
    let base: String?
    let main: Main?
    let visibility: Int
    let id: Int
    let name: String
    
    func toModel() -> CityDAO {
        let city = CityDAO(context: CoreDataManager.shared.context)
        city.id = Int32(id)
        city.name = name
        city.base = base
        city.visibility = Int32(visibility)
        if let coord = coord {
            city.coord = coord.toModel()
            city.coord?.city = city
        }
        if let main = main {
            city.main = main.toModel()
            city.main?.city = city
        }
        return city
    }
}

struct Coord: Codable {
    let lon: Double
    let lat: Double
    
    func toModel() -> CoordDAO {
        let coord = CoordDAO(context: CoreDataManager.shared.context)
        coord.lat = lat
        coord.lon = lon
        return coord
    }
}

struct Main: Codable {
    let temp: Double
    let humidity: Int
    
    func toModel() -> MainDAO {
        let main = MainDAO(context: CoreDataManager.shared.context)
        main.temp = temp
        main.humidity = Int32(humidity)
        return main
    }
}

struct History: Codable {
    let date: String
    
    func toModel() -> HistoryDAO {
        let history = HistoryDAO(context: CoreDataManager.shared.context)
        history.date = date
        return history
    }
}
