//
//  History.swift
//  WeatherApp
//
//  Created by Ahmed Elsman on 04/08/2024.
//

import Foundation

struct History: Codable {
    let date: String
    
    func toModel() -> HistoryDAO {
        let history = HistoryDAO(context: CoreDataManager.shared.context)
        history.date = date
        return history
    }
}
