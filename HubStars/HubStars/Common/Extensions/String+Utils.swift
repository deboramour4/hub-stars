//
//  String+Utils.swift
//  HubStars
//
//  Created by Debora Moura on 19/06/20.
//  Copyright © 2020 Debora Moura. All rights reserved.
//

import Foundation

extension String {
    static var empty: String { "" }
    
    static var space: String { " " }
    
    var firstCapitalized: String {
        return prefix(1).capitalized + dropFirst()
    }
}
