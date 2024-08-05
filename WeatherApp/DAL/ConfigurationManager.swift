//
//  ConfigurationManager.swift
//  WeatherApp
//
//  Created by Ahmed Elsman on 04/08/2024.
//

import Foundation

class ConfigurationManager {
    static let shared = ConfigurationManager()

    private init() {}

    var baseURL: URL {
        return URL(string: "https://api.openweathermap.org/data/2.5")!
    }

    var apiKey: String {
        return "f5cb0b965ea1564c50c6f1b74534d823"
    }

    var baseImageURL: URL {
        return URL(string: "https://openweathermap.org/img/w/")!
    }
}
