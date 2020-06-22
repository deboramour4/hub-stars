//
//  UIColor+Custom.swift
//  HubStars
//
//  Created by Debora Moura on 22/06/20.
//  Copyright © 2020 Debora Moura. All rights reserved.
//

import UIKit

// MARK: - Extension UIColor
extension UIColor {
    static func primary(alpha: Double) -> UIColor {
        UIColor(red: 255/255.0, green: 211/255.0, blue: 33/255.0, alpha: CGFloat(alpha))
    }
}
