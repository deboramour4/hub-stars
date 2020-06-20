//
//  ReposListViewModel.swift
//  HubStars
//
//  Created by Debora Moura on 19/06/20.
//  Copyright © 2020 Debora Moura. All rights reserved.
//

import Foundation

// MARK: - ReposListViewModel
final class ReposListViewModel {

    // MARK: - Properties
    private let service: GitHubServiceProtocol
    private var allRepos: [Repo] = []
    private var cellViewModels: [RepoCellViewModel] = []
    private var currentPage: Int = 1
    private let reposPerPage: Int = 30
    private var isOnRequest: Bool
    
    // MARK: - Typealias
    typealias NotifyClosure = (() -> (Void))?
    typealias IndexPathClosure = ((_ newIndexPathsToReload: [IndexPath]?) -> (Void))?
    
    // MARK: - Output
    public var successOnRequest: IndexPathClosure = nil
    public var errorOnRequest: NotifyClosure = nil
    public var titleText: String = AppKeys.ReposList.title.localized
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
                guard let currentPage = self?.currentPage else {
                    return
                }

                if !isRefresh {
                    self?.allRepos.append(contentsOf: repos.all)
                    self?.createCellViewModels(repos.all)
                    self?.currentPage += 1
                }

                if currentPage > 2 {
                    let indexPathsToRefresh = self?.indexPathsToRefresh(from: repos.all)
                    self?.successOnRequest?(indexPathsToRefresh)
                } else {
                    self?.numberOfRows = repos.totalCount
                    self?.successOnRequest?(.none)
                }

            case .failure(let error):
                print(error.localizedDescription)
                self?.errorOnRequest?()
            }
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
    public func getCellViewModel(for indexPath: IndexPath) -> RepoCellViewModel? {
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
