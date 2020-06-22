
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
        get {
            self.reposTableView
        }
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
        button.hasBlur = true
        button.alpha = Constants.alpha.hide
        button.addTarget(self, action: #selector(didTapBackToTop), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        return refresh
    }()

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
            backToTopButton.widthAnchor.constraint(equalToConstant: Constants.topButton.width),
        ])
    }
    
    override func layoutSubviews() {
        backToTopButton.frame = backToTopButton.frame
    }
    
    public func setup(with viewModel: RepositoriesViewModelProtocol?) {
        if var viewModel = viewModel {
            backToTopButton.title = viewModel.topButtonTitle
            
            viewModel.topButtonIsHidden = { [weak self] isListOnTop in
                let alpha = isListOnTop ? Constants.alpha.hide : Constants.alpha.show
                self?.changeBackToTopButtonAlpha(to: alpha)
            }
        }
        
        setupView()
    }
    
    private func changeBackToTopButtonAlpha(to value: CGFloat) {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       options: .curveEaseIn,
                       animations: { [weak self] in
            self?.backToTopButton.alpha = value
        })
    }
    
    @objc private func didTapBackToTop() {
        delegate?.repositoriesViewDidTapBackToTop(self)
        changeBackToTopButtonAlpha(to: Constants.alpha.hide)
    }
    
    @objc private func refreshAction(refreshControl: UIRefreshControl) {
        delegate?.repositoriesViewDidPullToRefresh(self)
        refreshControl.endRefreshing()
    }
}
