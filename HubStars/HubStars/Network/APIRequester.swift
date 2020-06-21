//
//  APIRequester.swift
//  HubStars
//
//  Created by Debora Moura on 19/06/20.
//  Copyright © 2020 Debora Moura. All rights reserved.
//

import Foundation

// MARK: - APIRequesterProtocol
protocol APIRequesterProtocol {
    func getJSON<T: Decodable>(endpoint: Endpoint, completion: @escaping ((Result<T, APIRequester.RequestError>) -> Void))
    func getData(endpoint: Endpoint, completion: @escaping ((Result<Data, APIRequester.RequestError>) -> Void))
}

// MARK: - APIRequesterProtocol
final class APIRequester: APIRequesterProtocol {
    
    // MARK: - Request error cases
    enum RequestError: Error {
        case invalidURL
        case emptyData
        case parseError(description: String)
        case rateLimitExceeded
        case unknown
        
        var localizedDescription: String {
            switch self {
            case .invalidURL:
                return "The given URL is not valid."
            case .emptyData:
                return "No data available in HTTP response."
            case .parseError(let description):
                return "Could not parse the current JSON object.\nMore info: \(description)"
            case .rateLimitExceeded:
                return "API rate limit exceeded for current IP address.\nCheck out the documentation for more details."
            case .unknown:
                return "Failed for unknow reasons."
            }
        }
    }
    
    // MARK: - Constructors
    init() { }
    
    // MARK: - HTTP Methods
    
    func getJSON<T: Decodable>(endpoint: Endpoint, completion: @escaping ((Result<T, APIRequester.RequestError>) -> Void)) {
        
        guard let request = endpoint.asRequest else {
            completion(.failure(RequestError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: request) { (result) in
            switch result {
            case .failure(_):
                completion(.failure(RequestError.unknown))
                
            case .success(let response, let data):
                let decoder = JSONDecoder()
                
                switch response.statusCode {
                case 200...299:
                    do {
                        let model = try decoder.decode(T.self, from: data)
                        completion(.success(model))
                    } catch let error {
                        completion(.failure(RequestError.parseError(description: error.localizedDescription)))
                    }
                case 403:
                    completion(.failure(RequestError.rateLimitExceeded))
                default:
                    completion(.failure(RequestError.unknown))
                }
            }
        }.resume()
    }
    
    func getData(endpoint: Endpoint, completion: @escaping ((Result<Data, APIRequester.RequestError>) -> Void)) {
        
        guard let request = endpoint.asRequest else {
            completion(.failure(RequestError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: request) { (result) in
            switch result {
            case .failure(_):
                completion(.failure(RequestError.unknown))
                
            case .success(_, let data):
                completion(.success(data))
            }
        }.resume()
    }
}
