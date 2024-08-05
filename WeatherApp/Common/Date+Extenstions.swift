//
//  Date+Extenstions.swift
//  WeatherApp
//
//  Created by Ahmed Elsman on 05/08/2024.
//

extension Date {
    func dateTimeString(format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

