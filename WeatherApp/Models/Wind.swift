//
//  Wind.swift
//  WeatherApp
//
//  Created by Ahmed Elsman on 04/08/2024.
//

import Foundation

struct Wind: Codable {
    let speed: Double
    
    func toModel() -> WindDAO {
        let wind = WindDAO(context: CoreDataManager.shared.context)
        wind.speed = speed
        return wind
    }
}
