//
//  ReposListViewController.swift
//  HubStars
//
//  Created by Debora Moura on 19/06/20.
//  Copyright © 2020 Debora Moura. All rights reserved.
//

import UIKit

// MARK: - ReposListViewControllerDelegate

protocol ReposListViewControllerDelegate: class {
    func reposListViewControllerDidSelectRepo(_ viewController: ReposListViewController, _ viewModel: RepoCellViewModel)
}

// MARK: - ReposListViewController
final class ReposListViewController: UIViewController {
    
    // MARK: - Properties
    private let reposListView = ReposListView()
    private let reposListViewModel: ReposListViewModel = ReposListViewModel()
    weak var delegate: ReposListViewControllerDelegate?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
                
        navigationController?.customizeNavigationBar()
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setupBinds()
    }
    override func loadView() {
        reposListView.delegate = self
        self.view = reposListView
    }
    
    // MARK: - Internal functions
    private func setupBinds() {
        title = reposListViewModel.titleText
        
        reposListView.tableView.delegate = self
        reposListView.tableView.dataSource = self
        
        reposListViewModel.errorOnRequest = { [weak self] in
            DispatchQueue.main.async {
                self?.presentAlert(AppKeys.ErrorNetwork.title.localized,
                                   message: AppKeys.ErrorNetwork.message.localized,
                                   actionTitle: AppKeys.General.tryAgain.localized,
                                   dismissTitle: AppKeys.General.cancel.localized,
                                   handler: { _ in
                    self?.reposListViewModel.viewDidTapTryAgain()
                })
            }
        }
        reposListView.setup(with: reposListViewModel)
    }
    
    @objc private func didTapLogout() {
        dismiss(animated: false, completion: nil)
    }
}

// MARK: - Extensions
extension ReposListViewController: ReposListViewDelegate {
    func reposListViewDidPullToRefresh(_ view: ReposListView) {
        reposListViewModel.viewDidPullToRefresh()
    }
}

extension ReposListViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return reposListViewModel.numberOfSections
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reposListViewModel.numberOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = String(describing: RepoCellView.self)
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? RepoCellView else { return UITableViewCell() }
        
        cell.setup(with: reposListViewModel.getCellViewModel(for: indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let viewModel = self.reposListViewModel.getCellViewModel(for: indexPath)
        delegate?.reposListViewControllerDidSelectRepo(self, viewModel)
    }
}
