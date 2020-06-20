//
//  Constants.swift
//  HubStars
//
//  Created by Debora Moura on 19/06/20.
//  Copyright © 2020 Debora Moura. All rights reserved.
//

import Foundation

struct K {
    static let thousandIndicator: String = "k"
    
    struct APIServer {
        static let baseURL: String = "https://api.github.com"
        struct ParameterKey {
            static let query: String = "q"
            static let sort: String = "sort"
            static let page: String = "page"
            static let perPage: String = "per_page"
        }
    }
    
}

public enum HTTPHeadersFields: String {
    case contentType = "Content-Type"
    case json = "application/json"
}
