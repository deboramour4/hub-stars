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
    let repositoriesView = RepositoriesView()
    var repositoriesViewModel: RepositoriesViewModelProtocol
    weak var delegate: RepositoriesViewControllerDelegate?
    
    // MARK: - Initializers
    init(viewModel: RepositoriesViewModelProtocol = RepositoriesViewModel()) {
        self.repositoriesViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        repositoriesViewModel.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
                
        navigationController?.customizeNavigationBar()
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setupBinds()
    }
    override func loadView() {
        self.view = repositoriesView
    }
    
    // MARK: - Private functions
    private func setupBinds() {
        title = repositoriesViewModel.titleText
        
        repositoriesView.delegate = self
        repositoriesView.tableView.delegate = self
        repositoriesView.tableView.dataSource = self
        
        repositoriesView.setup(with: repositoriesViewModel)
    }
}

// MARK: - Implements View Delegate
extension RepositoriesViewController: RepositoriesViewDelegate {
    func repositoriesViewDidTapBackToTop(_ view: RepositoriesView) {
        repositoriesView.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
    
    func repositoriesViewDidPullToRefresh(_ view: RepositoriesView) {
        repositoriesViewModel.viewDidPullToRefresh()
    }
}

// MARK: - Implements ViewModel Delegate
extension RepositoriesViewController: RepositoriesViewModelDelegate {
    func successOnRequest(_ updateIndexPaths: [IndexPath]?) {
        DispatchQueue.main.async { [weak self] in
            if let indexPaths = updateIndexPaths {
                self?.repositoriesView.tableView.insertRows(at: indexPaths, with: .fade)
            } else {
                self?.repositoriesView.tableView.reloadData()
            }
        }
    }
    
    func topButtonIsHidden(_ isHidden: Bool) {
        DispatchQueue.main.async { [weak self] in
            self?.repositoriesView.topButton(isHidden: isHidden)
        }
    }
    
    func errorOnRequest() {
        DispatchQueue.main.async { [weak self] in
            self?.presentAlert(AppKeys.ErrorNetwork.title.localized,
                               message: AppKeys.ErrorNetwork.message.localized,
                               actionTitle: AppKeys.General.tryAgain.localized,
                               dismissTitle: AppKeys.General.cancel.localized,
                               handler: { _ in
                                self?.repositoriesViewModel.viewDidTapTryAgain()
            })
        }
    }
}

// MARK: - Implements UITableViewDataSource and UITableViewDelegate
extension RepositoriesViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return repositoriesViewModel.numberOfSections
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if repositoriesViewModel.numberOfRows == 0 {
            return 1
        }
        return repositoriesViewModel.numberOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = String(describing: RepoCellView.self)
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? RepoCellView else {
            return UITableViewCell()
        }
        
        var viewModel = repositoriesViewModel.getCellViewModel(for: indexPath)
        viewModel?.delegate = cell
        cell.setup(with: viewModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let viewModel = self.repositoriesViewModel.getCellViewModel(for: indexPath)
        delegate?.repositoriesViewControllerDidSelectRepo(self, viewModel)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        repositoriesViewModel.viewWillDisplayCell(at: indexPath)
        
        if repositoriesViewModel.isEndOfList(indexPath) && repositoriesViewModel.numberOfRows > 0 {
            let emptyCell = RepoCellView(frame: cell.frame)
            emptyCell.setup(with: nil)
            emptyCell.frame.size = cell.frame.size
            
            tableView.tableFooterView = emptyCell
        }
    }
}
