//
//  RepositoriesViewController.swift
//  HubStars
//
//  Created by Debora Moura on 19/06/20.
//  Copyright © 2020 Debora Moura. All rights reserved.
//

import UIKit

// MARK: - RepositoriesViewControllerDelegate
protocol RepositoriesViewControllerDelegate: class {
    func repositoriesViewControllerDidSelectRepo(_ viewController: RepositoriesViewController, _ viewModel: RepoCellViewModelProtocol?)
}

// MARK: - RepositoriesViewController
final class RepositoriesViewController: UIViewController {
    
    // MARK: - Properties
    private let repositoriesView = RepositoriesView()
    private var repositoriesViewModel: RepositoriesViewModelProtocol = RepositoriesViewModel()
    weak var delegate: RepositoriesViewControllerDelegate?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
                
        navigationController?.customizeNavigationBar()
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setupBinds()
    }
    override func loadView() {
        self.view = repositoriesView
    }
    
    // MARK: - Internal functions
    private func setupBinds() {
        title = repositoriesViewModel.titleText
        
        repositoriesView.delegate = self
        repositoriesView.tableView.delegate = self
        repositoriesView.tableView.dataSource = self
        
        repositoriesViewModel.successOnRequest = { [weak self] indexPaths in
            DispatchQueue.main.async {
                if let indexPathsToReload = indexPaths {
                    self?.repositoriesView.tableView.insertRows(at: indexPathsToReload, with: .fade)
                } else {
                    self?.repositoriesView.tableView.reloadData()
                }
            }
        }
        repositoriesViewModel.errorOnRequest = { [weak self] in
            DispatchQueue.main.async {
                self?.presentAlert(AppKeys.ErrorNetwork.title.localized,
                                   message: AppKeys.ErrorNetwork.message.localized,
                                   actionTitle: AppKeys.General.tryAgain.localized,
                                   dismissTitle: AppKeys.General.cancel.localized,
                                   handler: { _ in
                    self?.repositoriesViewModel.viewDidTapTryAgain()
                })
            }
        }
        repositoriesView.setup()
    }
}

// MARK: - Extensions
extension RepositoriesViewController: RepositoriesViewDelegate {
    func repositoriesViewDidPullToRefresh(_ view: RepositoriesView) {
        repositoriesViewModel.viewDidPullToRefresh()
    }
}

extension RepositoriesViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return repositoriesViewModel.numberOfSections
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositoriesViewModel.numberOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = String(describing: RepoCellView.self)
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? RepoCellView else { return UITableViewCell() }
        
        cell.setup(with: repositoriesViewModel.getCellViewModel(for: indexPath))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let viewModel = self.repositoriesViewModel.getCellViewModel(for: indexPath)
        delegate?.repositoriesViewControllerDidSelectRepo(self, viewModel)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == repositoriesViewModel.numberOfRows {
            let emptyCell = RepoCellView(frame: cell.frame)
            emptyCell.setup(with: nil)
            emptyCell.frame.size = cell.frame.size
            
            tableView.tableFooterView = emptyCell
            repositoriesViewModel.viewDidShowAllRepos()
        }
        
    }
}
