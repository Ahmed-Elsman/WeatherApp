//
//  PresenterState.swift
//  WeatherApp
//
//  Created by Ahmed Elsman on 04/08/2024.
//

import Foundation

public enum PresenterState<T> {
    case loading
    case loaded(data: T)
    case error(error: APIError)
}
