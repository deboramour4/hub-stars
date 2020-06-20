//
//  Constants.swift
//  HubStars
//
//  Created by Debora Moura on 19/06/20.
//  Copyright © 2020 Debora Moura. All rights reserved.
//

import Foundation

struct K {
    struct APIServer {
        static let baseURL: String = "https://api.github.com"
//        static let dateFormat: String = "yyyy-MM-dd"
    }
    
    struct APIParameterKey {
        static let query: String = "q"
        static let sort: String = "sort"
    }
}

public enum HTTPHeadersFields: String {
    case contentType = "Content-Type"
    case json = "application/json"
}
