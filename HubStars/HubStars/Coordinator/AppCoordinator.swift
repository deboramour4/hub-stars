//
//  AppCoordinator.swift
//  HubStars
//
//  Created by Debora Moura on 19/06/20.
//  Copyright © 2020 Debora Moura. All rights reserved.
//

import UIKit

// MARK: - AppCoordinator
final class AppCoordinator: Coordinator {
    
    // MARK: - Properties
    private let window: UIWindow
    private let rootViewController: UINavigationController
    private let reposListCoordinator: ReposListCoordinator

    // MARK: - Constructors
    init(window: UIWindow) {
        self.window = window
        rootViewController = UINavigationController()
        reposListCoordinator = ReposListCoordinator(presenter: rootViewController)
    }
    
    // MARK: - Internal functions
    func start() {
        window.rootViewController = rootViewController
        reposListCoordinator.start()
        window.makeKeyAndVisible()
    }
}
