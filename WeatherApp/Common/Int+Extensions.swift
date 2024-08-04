//
//  Int+Extensions.swift
//  WeatherApp
//
//  Created by Ahmed Elsman on 04/08/2024.
//

import Foundation

extension UUID {
    func generateRandomInt() -> Int {
        let uuidString = self.uuidString
        let uuidHash = uuidString.hash
        return abs(uuidHash % 100)
    }
}
