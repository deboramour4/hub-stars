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
    func getJSON<T: Decodable>(service: Service, completion: @escaping ((Result<T, APIRequester.RequestError>) -> Void))
    func getData(service: Service, completion: @escaping ((Result<Data, APIRequester.RequestError>) -> Void))
}

// MARK: - HTTP headers

public typealias HTTPParameters = [String: Any]

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

enum HTTPHeader {
    case contentType
    
    var value: [String : String] {
        switch self {
        case .contentType:
            return ["Content-type": "application/json"]
        }
    }
}


// MARK: - APIRequesterProtocol
final class APIRequester: APIRequesterProtocol {
    
    // MARK: - Request error cases
    enum RequestError: Error {
        case invalidURL
        case parseError
        case requestError
        case noJSONData
        case unknown
    }
    
    // MARK: - Constructors
    init() { }
    
    // MARK: - HTTP Methods
    
    func getJSON<T: Decodable>(service: Service, completion: @escaping ((Result<T, APIRequester.RequestError>) -> Void)) {
        
        guard let request = service.asRequest() else {
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
                    } catch {
                        completion(.failure(RequestError.parseError))
                    }
                default:
                    completion(.failure(RequestError.unknown))
                }
            }
        }.resume()
    }
    
    func getData(service: Service, completion: @escaping ((Result<Data, APIRequester.RequestError>) -> Void)) {
        
        guard let request = service.asRequest() else {
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
