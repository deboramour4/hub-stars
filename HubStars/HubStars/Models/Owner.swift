//
//  Owner.swift
//  HubStars
//
//  Created by Debora Moura on 22/06/20.
//  Copyright © 2020 Debora Moura. All rights reserved.
//

import Foundation

// MARK: - Owner
struct Owner: Codable {
    
    // MARK: - Properties
    let login: String
    let id: Int
    let avatarURL: String

    // MARK: - CodingKeys
    enum CodingKeys: String, CodingKey {
        case id
        case login
        case avatarURL = "avatar_url"
    }
}
