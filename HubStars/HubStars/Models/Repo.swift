//
//  Repo.swift
//  HubStars
//
//  Created by Debora Moura on 19/06/20.
//  Copyright © 2020 Debora Moura. All rights reserved.
//

import Foundation

// MARK: - Repo
struct Repo: Codable {
    
    // MARK: - Properties
    let id: Int
    let name: String
    let owner: Owner
    let htmlURL: String
    let stars: Int

    // MARK: - CodingKeys
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case owner
        case htmlURL = "html_url"
        case stars = "stargazers_count"
    }
}
