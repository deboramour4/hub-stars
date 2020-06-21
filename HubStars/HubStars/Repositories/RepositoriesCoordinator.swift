//
//  RepositoriesCoordinator.swift
//  HubStars
//
//  Created by Debora Moura on 19/06/20.
//  Copyright © 2020 Debora Moura. All rights reserved.
//

import UIKit
import SafariServices

// MARK: - RepositoriesCoordinator
final class RepositoriesCoordinator: Coordinator {
    
    // MARK: - Properties
    private let presenter: UINavigationController
    private var viewController: RepositoriesViewController?
    private var safariViewController: SFSafariViewController?
    
    // MARK: - Constructors
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
    // MARK: - Internal functions
    func start() {
        let viewController = RepositoriesViewController()
        viewController.delegate = self
        presenter.pushViewController(viewController, animated: true)
        self.viewController = viewController
    }
}

// MARK: - Extensions
extension RepositoriesCoordinator: RepositoriesViewControllerDelegate {
    func repositoriesViewControllerDidSelectRepo(_ viewController: RepositoriesViewController, _ viewModel: RepoCellViewModelProtocol?) {
        if let viewModel = viewModel,
            let url = URL(string: viewModel.repoUrlString) {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true

            let safariViewController = SFSafariViewController(url: url, configuration: config)
            presenter.present(safariViewController, animated: true, completion: nil)
        }
    }
}
