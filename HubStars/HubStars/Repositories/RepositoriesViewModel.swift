//
//  RepositoriesViewModel.swift
//  HubStars
//
//  Created by Debora Moura on 19/06/20.
//  Copyright © 2020 Debora Moura. All rights reserved.
//

import Foundation

// MARK: - RepositoriesViewModelProtocol
protocol RepositoriesViewModelProtocol {
    typealias NotifyClosure = (() -> (Void))?
    typealias IndexPathClosure = (([IndexPath]?) -> (Void))?
    var successOnRequest: IndexPathClosure { get set }
    var errorOnRequest: NotifyClosure { get set }
    var titleText: String { get }
    var numberOfRows: Int { get }
    var numberOfSections: Int { get }
    var currentCountOfRepos: Int { get }
    func getCellViewModel(for indexPath: IndexPath) -> RepoCellViewModelProtocol?
    func viewDidPullToRefresh()
    func viewDidTapTryAgain()
    func viewDidShowAllRepos()
}

// MARK: - RepositoriesViewModel
final class RepositoriesViewModel: RepositoriesViewModelProtocol {

    // MARK: - Properties
    private let service: GitHubServiceProtocol
    private var allRepos: [Repo] = []
    private var cellViewModels: [RepoCellViewModel] = []
    private var currentPage: Int = 1
    private let reposPerPage: Int = 30
    private var isOnRequest: Bool
    
    // MARK: - Output
    public var successOnRequest: IndexPathClosure = nil
    public var errorOnRequest: NotifyClosure = nil
    public var titleText: String = AppKeys.Repositories.title.localized
    public var numberOfRows: Int = 0
    public var numberOfSections: Int = 1
    public var currentCountOfRepos: Int {
        return allRepos.count
    }
    
    // MARK: - Constructors
    init(_ service: GitHubServiceProtocol = GitHubService()) {
        self.service = service
        isOnRequest = false
        requestRepos(isRefresh: false)
    }
    
    // MARK: - Internal functions
    private func requestRepos(isRefresh: Bool) {
        guard !isOnRequest else {
          return
        }
        isOnRequest = true
        
        service.getRepos(perPage: reposPerPage, page: currentPage) { [weak self] (result) in
            self?.isOnRequest = false

            switch result {
            case .success(let repos):
                self?.handleSuccess(repos, isRefresh: isRefresh)

            case .failure(let error):
                print(error.localizedDescription)
                self?.errorOnRequest?()
            }
        }
    }
    
    private func handleSuccess(_ repos: Repos, isRefresh: Bool) {
        if !isRefresh {
            allRepos.append(contentsOf: repos.all)
            createCellViewModels(repos.all)
            currentPage += 1
        }
        
        if currentPage > 2 {
            let indexPaths = indexPathsToRefresh(from: repos.all)
            successOnRequest?(indexPaths)
        } else {
            numberOfRows = repos.totalCount
            successOnRequest?(.none)
        }
    }
    
    private func indexPathsToRefresh(from newRepos: [Repo]) -> [IndexPath] {
        let initialIndex = allRepos.count - newRepos.count
        let finalIndex = initialIndex + newRepos.count
        let indexPaths = (initialIndex..<finalIndex).map { IndexPath(row: $0, section: 0) }
        return indexPaths
    }
    
    private func createCellViewModels(_ repos: [Repo]) {
        for repo in repos {
            let cellViewModel = RepoCellViewModel(repo: repo)
            cellViewModels.append(cellViewModel)
        }
    }
    
    // MARK: - Public functions
    public func getCellViewModel(for indexPath: IndexPath) -> RepoCellViewModelProtocol? {
        if indexPath.row >= allRepos.count {
            return nil
        }
        return cellViewModels[indexPath.row]
    }
    public func viewDidPullToRefresh() {
        requestRepos(isRefresh: true)
    }
    public func viewDidTapTryAgain() {
        requestRepos(isRefresh: false)
    }
    public func viewDidShowAllRepos() {
        requestRepos(isRefresh: false)
    }
}
