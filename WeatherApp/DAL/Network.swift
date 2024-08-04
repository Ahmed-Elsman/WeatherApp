//
//  Network.swift
//  WeatherApp
//
//  Created by Ahmed Elsman on 04/08/2024.
//

/*
import Foundation

public protocol URLSessionProtocol {
    func data(from request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void)
}

extension URLSession: URLSessionProtocol {
    public func data(from request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let task = dataTask(with: request, completionHandler: completion)
        task.resume()
    }
}

public protocol NetworkManaging {
    func fetchData<T: Decodable>(from endpoint: APIEndpoint, completion: @escaping (Result<T, Error>) -> Void)
}

public struct NetworkManager: NetworkManaging {
    
    let session: URLSessionProtocol
    let decoder: JSONDecoder
    
    public init(withSession session: URLSessionProtocol? = nil, decoder: JSONDecoder = JSONDecoder()) {
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = false
        self.session = session ?? URLSession(configuration: config)
        self.decoder = decoder
    }
    
    public func fetchData<T: Decodable>(from endpoint: APIEndpoint, completion: @escaping (Result<T, Error>) -> Void) {
        let request = endpoint.request
        
        session.data(from: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data, let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(APIError.invalidResponse))
                return
            }
            
            do {
                let decodedData = try self.decoder.decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(APIError.decodingError))
            }
        }
    }
}
*/
