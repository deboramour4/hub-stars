//
//  Repos.swift
//  HubStars
//
//  Created by Debora Moura on 19/06/20.
//  Copyright © 2020 Debora Moura. All rights reserved.
//

import Foundation

// MARK: - Repositories
struct Repositories: Codable {
    
    // MARK: - Properties
    let totalCount: Int
    let incompleteResults: Bool
    let all: [Repo]

    // MARK: - CodingKeys
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case all = "items"
    }
}
