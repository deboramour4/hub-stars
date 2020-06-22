//
//  String+Utils.swift
//  HubStars
//
//  Created by Debora Moura on 19/06/20.
//  Copyright © 2020 Debora Moura. All rights reserved.
//

import Foundation

// MARK: - Extension String
extension String {
    static var empty: String { "" }
    static var space: String { " " }
    static var point: String { "." }
    
    var firstCapitalized: String {
        return prefix(1).capitalized + dropFirst()
    }
}
