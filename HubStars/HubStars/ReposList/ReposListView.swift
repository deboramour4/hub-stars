
//
//  ReposView.swift
//  HubStars
//
//  Created by Debora Moura on 19/06/20.
//  Copyright © 2020 Debora Moura. All rights reserved.
//

import UIKit

// MARK: - ReposListViewDelegate
protocol ReposListViewDelegate: class {
    func reposListViewDidPullToRefresh(_ view: ReposListView)
}

// MARK: - ReposListView
final class ReposListView: UIView {
    
    weak var delegate: ReposListViewDelegate?
    
    // MARK: - Constants
    private struct Constants {
        struct tableView {
            static let identifier: String = String(describing: RepoCellView.self)
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

    private var loadingView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.startAnimating()
        view.style = .large
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.attributedTitle = NSAttributedString(string: "Pull to refresh", attributes: [NSAttributedString.Key.font: UIFont.p2 as Any])
        return refresh
    }()

    // MARK: - Setup
    private func setupView() {
        backgroundColor = .systemBackground
        
        refreshControl.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        addSubview(reposTableView)
        addSubview(loadingView)

        NSLayoutConstraint.activate([
            reposTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            reposTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            reposTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            reposTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            loadingView.topAnchor.constraint(equalTo: topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    public func setup(with viewModel: ReposListViewModel) {
        viewModel.successOnRequest = { [weak self] in
            DispatchQueue.main.async {
                self?.reposTableView.reloadData()
            }
        }
        
        viewModel.onRequest = { [weak self] isLoading in
            DispatchQueue.main.async {
                self?.loadingView.isHidden = !isLoading
            }
        }
        
        loadingView.isHidden = true
        setupView()
    }
    
    @objc private func refreshAction(refreshControl: UIRefreshControl) {
        delegate?.reposListViewDidPullToRefresh(self)
        refreshControl.endRefreshing()
    }
}
