//
//  Repo.swift
//  HubStars
//
//  Created by Debora Moura on 19/06/20.
//  Copyright © 2020 Debora Moura. All rights reserved.
//

import Foundation

// MARK: - Item
struct Repo: Codable {
    let id: Int
    let name:String
    let fullName: String
    let owner: Owner
    let htmlURL: String
    let description: String
//    let createdAt: Date
    let stars: Int

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case fullName = "full_name"
        case owner
        case htmlURL = "html_url"
        case description
//        case createdAt = "created_at"
        case stars = "stargazers_count"
    }
}

// MARK: - Owner
struct Owner: Codable {
    let login: String
    let id: Int
    let avatarURL: String

    enum CodingKeys: String, CodingKey {
        case id
        case login
        case avatarURL = "avatar_url"
    }
}
