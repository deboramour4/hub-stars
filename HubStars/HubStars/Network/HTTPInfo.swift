//
//  HTTPMethods.swift
//  HubStars
//
//  Created by Debora Moura on 21/06/20.
//  Copyright © 2020 Debora Moura. All rights reserved.
//

import Foundation

// MARK: - HTTPInfo
public struct HTTPInfo {
    typealias Parameters = [String: Any]
    
    enum Method: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case patch = "PATCH"
        case delete = "DELETE"
    }
    
    enum Header {
        case contentType
        
        var value: [String: String] {
            switch self {
            case .contentType:
                return ["Content-type": "application/json"]
            }
        }
    }
}
