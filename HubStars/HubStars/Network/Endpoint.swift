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
    
    // MARK: - URL
    var url: String {
        switch self {
        case .repos:
            let baseUrl = K.APIServer.baseURL
            let fullURL = baseUrl.appending(path)
            return fullURL
        case .image(let url):
            return url
        }
    }
    
    // MARK: - HTTPMethod
    var method: HTTPInfo.Method {
        switch self {
        case .repos, .image:
            return .get
        }
    }
    
    // MARK: - HTTPHeaders
    var headers: [HTTPInfo.Header] {
        switch self {
        case .repos, .image:
            return [.contentType]
        }
    }
    
    // MARK: - Path
    var path: String {
        switch self {
        case .repos:
            return "/search/repositories"
        case .image:
            return .empty
        }
    }
    
    // MARK: - Parameters
    var parameters: HTTPInfo.Parameters {
        switch self {
        case .repos(let perPage, let page):
            return [K.APIServer.ParameterKey.query: "language:swift",
                    K.APIServer.ParameterKey.sort: "stars",
                    K.APIServer.ParameterKey.page: page,
                    K.APIServer.ParameterKey.perPage: perPage]
        case .image:
            return [:]
        }
    }
    
    // MARK: - URLRequest
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
