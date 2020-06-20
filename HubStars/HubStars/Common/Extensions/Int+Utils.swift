//
//  Int+Utils.swift
//  HubStars
//
//  Created by Debora Moura on 19/06/20.
//  Copyright © 2020 Debora Moura. All rights reserved.
//

import Foundation

extension Int {
    var thousandFormat: String {
        let formatter = NumberFormatter()
        formatter.minimumIntegerDigits = 1
        formatter.maximumFractionDigits = 1
        formatter.numberStyle = .decimal
        formatter.positiveSuffix = K.thousandIndicator
    
        let number = Double(self)
        let thousand = number / 1000
        if thousand >= 1.0 {
            return formatter.string(from: thousand as NSNumber) ?? String.empty
        } else {
            return self.description
        }
    }
}
