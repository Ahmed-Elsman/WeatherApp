//
//  Coord.swift
//  WeatherApp
//
//  Created by Ahmed Elsman on 04/08/2024.
//

import Foundation

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
