//
//  Main.swift
//  WeatherApp
//
//  Created by Ahmed Elsman on 04/08/2024.
//

import Foundation

struct Main: Codable {
    let temp: Double
    let humidity: Int

    func toModel() -> MainDAO {
        let main = MainDAO(context: CoreDataManager.shared.context)
        main.temp = temp
        main.humidity = Int32(humidity)
        return main
    }

    var tempCelsius: Double {
        return temp - 273.15
    }
}
