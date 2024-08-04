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
    let wind: Wind?
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
        if let wind = wind {
            city.wind = wind.toModel()
            city.wind?.city = city
        }
        return city
    }
}

