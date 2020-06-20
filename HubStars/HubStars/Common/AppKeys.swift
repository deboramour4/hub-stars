//
//  AppKeys.swift
//  HubStars
//
//  Created by Debora Moura on 20/06/20.
//  Copyright © 2020 Debora Moura. All rights reserved.
//

import Foundation

struct AppKeys {
    enum General: String, LocalizableKeys {
        case refreshTitle
        case backToTopTitle
        case tryAgain
        case cancel
        
        var prefix: String {
            String(describing: General.self)
        }
    }

    enum ErrorNetwork: String, LocalizableKeys {
        case title
        case message
        
        var prefix: String {
            String(describing: ErrorNetwork.self)
        }
    }
    enum ReposList: String, LocalizableKeys {
        case title
        
        var prefix: String {
            String(describing: ReposList.self)
        }
    }
}
