//
//  ReposView.swift
//  HubStars
//
//  Created by Debora Moura on 19/06/20.
//  Copyright © 2020 Debora Moura. All rights reserved.
//

import UIKit

// MARK: - RepositoriesViewDelegate
protocol RepositoriesViewDelegate: class {
    func repositoriesViewDidPullToRefresh(_ view: RepositoriesView)
    func repositoriesViewDidTapBackToTop(_ view: RepositoriesView)
}

// MARK: - RepositoriesView
final class RepositoriesView: UIView {
    
    // MARK: - Properties
    weak var delegate: RepositoriesViewDelegate?
    
    // MARK: - Constants
    private struct Constants {
        struct tableView {
            static let identifier: String = String(describing: RepoCellView.self)
        }
        struct topButton {
            static let top: CGFloat = 25
            static let width: CGFloat = 160
        }
        struct alpha {
            static let show: CGFloat = 1.0
            static let hide: CGFloat = 0.0
        }
    }

    // MARK: - UI Elements
    public var tableView: UITableView {
        self.reposTableView
    }

    private var reposTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(RepoCellView.self, forCellReuseIdentifier: Constants.tableView.identifier)
        return tableView
    }()
    
    private var backToTopButton: AppButton = {
        let button = AppButton(type: .custom)
        button.addTarget(self, action: #selector(didTapBackToTop), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        return refresh
    }()

    // MARK: - LifeCycle
    override func layoutSubviews() {
        backToTopButton.frame = backToTopButton.frame
    }
    
    // MARK: - Private Functions
    @objc private func didTapBackToTop() {
        delegate?.repositoriesViewDidTapBackToTop(self)
        topButton(isHidden: true)
    }
    
    @objc private func refreshAction(refreshControl: UIRefreshControl) {
        delegate?.repositoriesViewDidPullToRefresh(self)
        refreshControl.endRefreshing()
    }
    
    // MARK: - Setup
    private func setupView() {
        backgroundColor = .systemBackground
        
        refreshControl.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        addSubview(reposTableView)
        addSubview(backToTopButton)

        NSLayoutConstraint.activate([
            reposTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            reposTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            reposTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            reposTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            backToTopButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Constants.topButton.top),
            backToTopButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            backToTopButton.widthAnchor.constraint(equalToConstant: Constants.topButton.width)
        ])
    }
    
    public func setup(with viewModel: RepositoriesViewModelProtocol?) {
        if let viewModel = viewModel {
            backToTopButton.title = viewModel.topButtonTitle
            backToTopButton.alpha = viewModel.topButtonIsHiddenInitialValue ? Constants.alpha.hide : Constants.alpha.show
        }
        setupView()
    }
    
    // MARK: - Internal Functions
    func topButton(isHidden: Bool) {
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: .curveEaseIn,
                       animations: { [weak self] in
                        self?.backToTopButton.alpha = isHidden ? Constants.alpha.hide : Constants.alpha.show
        })
    }
}
