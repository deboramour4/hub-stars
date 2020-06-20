
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
        tableView.showsVerticalScrollIndicator = false
        tableView.register(RepoCellView.self, forCellReuseIdentifier: Constants.tableView.identifier)
        return tableView
    }()
    
    private var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.attributedTitle = NSAttributedString(string: AppKeys.General.refreshTitle.localized,
                                                     attributes: [NSAttributedString.Key.font: UIFont.p2 as Any])
        return refresh
    }()

    // MARK: - Setup
    private func setupView() {
        backgroundColor = .systemBackground
        
        refreshControl.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        addSubview(reposTableView)

        NSLayoutConstraint.activate([
            reposTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            reposTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            reposTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            reposTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    public func setup() {        
        setupView()
    }
    
    @objc private func refreshAction(refreshControl: UIRefreshControl) {
        delegate?.reposListViewDidPullToRefresh(self)
        refreshControl.endRefreshing()
    }
}
