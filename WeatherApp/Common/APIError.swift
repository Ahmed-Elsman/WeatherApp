//
//  APIError.swift
//  WeatherApp
//
//  Created by Ahmed Elsman on 04/08/2024.
//

import Foundation

public enum APIError: Error {
    case invalidResponse
    case decodingError
    case noData

    var localizedDescription: String {
        switch self {
        case .invalidResponse:
            return "Invalid response, please check url request or parameters"
        case .decodingError:
            return "Decoding Error, please check model keys carefully"
        case .noData:
            return "No Data Found!"
        }
    }
}
