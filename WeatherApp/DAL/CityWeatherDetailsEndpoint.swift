//
//  CityWeatherDetailsEndpoint.swift
//  WeatherApp
//
//  Created by Ahmed Elsman on 04/08/2024.
//

import Foundation

public struct CityWeatherDetailsEndpoint: APIEndpoint {

    let cityName: String

    public var path: String {
        return "/weather"
    }

    public var queryItems: [URLQueryItem] {
        return [URLQueryItem(name: "q", value: cityName)]
    }

    public var requestType: RequestType {
        return .get
    }

    public var acceptType: AcceptType {
        return .json
    }

    public var shouldSaveToDatabase: Bool {
        return true
    }
}
