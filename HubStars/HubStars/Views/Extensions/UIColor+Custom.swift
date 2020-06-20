//
//  UIColor+Custom.swift
//  HubStars
//
//  Created by Debora Moura on 19/06/20.
//  Copyright © 2020 Debora Moura. All rights reserved.
//

import UIKit

// MARK: - Extension UIColor
extension UIColor {
    static let textColor = UIColor(red: 46/255.0, green: 45/255.0, blue: 51/255.0, alpha: 1.0)
    static let filterBlack = UIColor(white: 0.0, alpha: 0.2)
    
    static func primary(alpha: CGFloat = 1.0) -> UIColor {
        UIColor(red: 238/255.0, green: 46/255.0, blue: 93/255.0, alpha: alpha)
    }
    
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}
