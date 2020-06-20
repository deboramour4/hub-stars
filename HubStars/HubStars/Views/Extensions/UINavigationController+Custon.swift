//
//  UINavigationController+Custon.swift
//  HubStars
//
//  Created by Debora Moura on 19/06/20.
//  Copyright © 2020 Debora Moura. All rights reserved.
//

import UIKit

extension UINavigationController {
    func customizeNavigationBar() {
        navigationBar.largeTitleTextAttributes = [
            .foregroundColor: UIColor.label,
            .font: UIFont.navBarLargeTitle ?? UIFont.systemFont(ofSize: 34, weight: .heavy)
        ]
        navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.label,
            .font: UIFont.navbarTitle ?? UIFont.systemFont(ofSize: 22, weight: .heavy)
        ]
    }
}
