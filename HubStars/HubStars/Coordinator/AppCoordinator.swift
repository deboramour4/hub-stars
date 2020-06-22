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
    private let repositoriesCoordinator: RepositoriesCoordinator

    // MARK: - Initializers
    init(window: UIWindow) {
        self.window = window
        rootViewController = UINavigationController()
        repositoriesCoordinator = RepositoriesCoordinator(presenter: rootViewController)
    }
    
    // MARK: - Internal functions
    func start() {
        window.rootViewController = rootViewController
        repositoriesCoordinator.start()
        window.makeKeyAndVisible()
    }
}
