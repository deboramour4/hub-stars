//
//  Endpoint.swift
//  HubStars
//
//  Created by Debora Moura on 19/06/20.
//  Copyright © 2020 Debora Moura. All rights reserved.
//

import Foundation

// MARK: - EndpointProtocol
protocol EndpointProtocol {
    var url: String { get }
    var method: HTTPInfo.Method { get }
    var headers: [HTTPInfo.Header] { get }
    var path: String { get }
    var parameters: HTTPInfo.Parameters { get }
    var asRequest: URLRequest? { get }
}

// MARK: - Endpoint
enum Endpoint: EndpointProtocol {
    
    // MARK: - Cases
    case repos(perPage: Int, page: Int)
    case image(url: String)
    
    // MARK: - Computed properties
    var url: String {
        switch self {
        case .repos:
            let baseUrl = AppConstants.APIServer.baseURL
            let fullURL = baseUrl.appending(path)
            return fullURL
        case .image(let url):
            return url
        }
    }
    
    var method: HTTPInfo.Method {
        switch self {
        case .repos, .image:
            return .get
        }
    }
    
    var headers: [HTTPInfo.Header] {
        switch self {
        case .repos, .image:
            return [.contentType]
        }
    }
    
    var path: String {
        switch self {
        case .repos:
            return "/search/repositories"
        case .image:
            return .empty
        }
    }
    
    var parameters: HTTPInfo.Parameters {
        switch self {
        case .repos(let perPage, let page):
            return [AppConstants.APIServer.ParameterKey.query: "language:swift",
                    AppConstants.APIServer.ParameterKey.sort: "stars",
                    AppConstants.APIServer.ParameterKey.page: page,
                    AppConstants.APIServer.ParameterKey.perPage: perPage]
        case .image:
            return [:]
        }
    }
    
    var asRequest: URLRequest? {
        guard var urlComponents = URLComponents(string: url) else {
            return nil
        }
        urlComponents.queryItems = parameters.map { key, value in
            return URLQueryItem(name: key, value: String(describing: value))
        }
        guard let finalUrl = urlComponents.url else {
            return nil
        }
        var request = URLRequest(url: finalUrl)
        request.httpMethod = method.rawValue
        headers.forEach { (header) in
            header.value.forEach { (key, value) in
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        return request
    }
}
