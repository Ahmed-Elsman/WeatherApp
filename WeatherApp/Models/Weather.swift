//
//  Weather.swift
//  WeatherApp
//
//  Created by Ahmed Elsman on 05/08/2024.
//

import Foundation

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
    let dateTime: Date?
    
    func toModel() -> WeatherDAO {
        let weather = WeatherDAO(context: CoreDataManager.shared.context)
        weather.id = Int32(id)
        weather.main = main
        weather.descriptions = description
        weather.icon = icon
        weather.dateTime = dateTime
        return weather
    }
}
