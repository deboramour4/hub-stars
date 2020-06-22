//
//  AppKeys.swift
//  HubStars
//
//  Created by Debora Moura on 20/06/20.
//  Copyright © 2020 Debora Moura. All rights reserved.
//

import Foundation

// MARK: - AppKeys
struct AppKeys {
    
    // MARK: - General
    enum General: String, LocalizableKeys {
        case tryAgain
        case cancel
        
        var prefix: String {
            String(describing: General.self)
        }
    }
    
    // MARK: - ErrorNetwork
    enum ErrorNetwork: String, LocalizableKeys {
        case title
        case message
        
        var prefix: String {
            String(describing: ErrorNetwork.self)
        }
    }
    
    // MARK: - Repositories
    enum Repositories: String, LocalizableKeys {
        case title
        case topButton
        
        var prefix: String {
            String(describing: Repositories.self)
        }
    }
}
