//
//  LocalizableKeys.swift
//  HubStars
//
//  Created by Debora Moura on 20/06/20.
//  Copyright © 2020 Debora Moura. All rights reserved.
//

import Foundation

// MARK: - LocalizableKeys
protocol LocalizableKeys {
    var rawValue: String { get }
    var localized: String { get }
    var prefix: String { get }
}

// MARK: - Extension
extension LocalizableKeys {
    var localized: String {
        let string = "\(self.prefix)-\(self.rawValue.firstCapitalized)"
        return NSLocalizedString(string, comment: .empty)
    }
    
    func formattedString(_ values: CVarArg...) -> String {
        return String(format: self.localized, arguments: values)
    }
}
