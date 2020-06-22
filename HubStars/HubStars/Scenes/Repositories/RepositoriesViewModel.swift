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
    typealias NotifyClosure = (() -> Void)?
    typealias BoolClosure = ((Bool) -> Void)?
    typealias IndexPathClosure = (([IndexPath]?) -> Void)?
    var successOnRequest: IndexPathClosure { get set }
    var errorOnRequest: NotifyClosure { get set }
    var topButtonIsHidden: BoolClosure { get set }
    var topButtonTitle: String { get }
    var titleText: String { get }
    var numberOfRows: Int { get }
    var numberOfSections: Int { get }
    func getCellViewModel(for indexPath: IndexPath) -> RepoCellViewModelProtocol?
    func viewDidPullToRefresh()
    func viewDidTapTryAgain()
    func viewWillDisplayCell(at indexPath: IndexPath)
    func isEndOfList(_ indexPath: IndexPath) -> Bool
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
    private var isListOnTop: Bool = true
    
    // MARK: - Output
    public var successOnRequest: IndexPathClosure = nil
    public var errorOnRequest: NotifyClosure = nil
    public var topButtonIsHidden: BoolClosure = nil
    public var titleText: String = AppKeys.Repositories.title.localized
    public var numberOfSections: Int = 1
    public var topButtonTitle: String {
        "↑ \(AppKeys.Repositories.topButton.localized)"
    }
    public var numberOfRows: Int {
        allRepos.count
    }
    
    // MARK: - Initializers
    init(_ service: GitHubServiceProtocol = GitHubService()) {
        self.service = service
        isOnRequest = false
        requestRepos(isRefresh: false)
    }
    
    // MARK: - Private functions
    private func requestRepos(isRefresh: Bool) {
        guard !isOnRequest else {
          return
        }
        isOnRequest = true
        
        service.getRepos(perPage: reposPerPage, page: currentPage) { [weak self] (result) in
            self?.isOnRequest = false

            switch result {
            case .success(let repositories):
                self?.handleSuccess(repositories, isRefresh: isRefresh)

            case .failure(let error):
                print(error.localizedDescription)
                self?.errorOnRequest?()
            }
        }
    }
    
    private func handleSuccess(_ repositories: Repositories, isRefresh: Bool) {
        if !isRefresh {
            allRepos.append(contentsOf: repositories.all)
            createCellViewModels(repositories.all)
            currentPage += 1
        }
        
        if currentPage > 2 && !isRefresh {
            let indexPaths = indexPathsToRefresh(from: repositories.all)
            successOnRequest?(indexPaths)
        } else {
            successOnRequest?(.none)
        }
    }
    
    private func indexPathsToRefresh(from newRepos: [Repo]) -> [IndexPath] {
        let initialIndex = allRepos.count - newRepos.count
        let finalIndex = initialIndex + newRepos.count
        let indexPaths = (initialIndex..<finalIndex).map { IndexPath(row: $0, section: 0) }
        return indexPaths
    }
    
    private func createCellViewModels(_ repositories: [Repo]) {
        for repo in repositories {
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

    public func viewWillDisplayCell(at indexPath: IndexPath) {
        if indexPath.row > reposPerPage {
            if isListOnTop {
                topButtonIsHidden?(false)
                isListOnTop = false
            }
        } else {
            if !isListOnTop {
                topButtonIsHidden?(true)
                isListOnTop = true
            }
        }
    }

    public func isEndOfList(_ indexPath: IndexPath) -> Bool {
        if indexPath.row + 1 == allRepos.count {
            requestRepos(isRefresh: false)
            return true
        }
        return false
    }
}
