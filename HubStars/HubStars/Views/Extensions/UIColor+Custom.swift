//
//  UIColor+Custom.swift
//  HubStars
//
//  Created by Debora Moura on 22/06/20.
//  Copyright © 2020 Debora Moura. All rights reserved.
//

import UIKit

extension UIColor {
    static func primary(alpha: Double) -> UIColor {
        UIColor(red: 252/255.0, green: 228/255.0, blue: 92/255.0, alpha: CGFloat(alpha))
    }
}
