//
//  DataLoader.swift
//  WeatherAppTests
//
//  Created by Ahmed Elsman on 05/08/2024.
//


import Foundation

final class DataLoader {
    func loadJsonData(file: String) -> Data? {
        if let jsonFilePath = Bundle(for: type(of: self)).path(forResource: file, ofType: "json") {
            let jsonFileURL = URL(fileURLWithPath: jsonFilePath)

            if let jsonData = try? Data(contentsOf: jsonFileURL) {
                return jsonData
            }
        }

        return nil
    }
}
