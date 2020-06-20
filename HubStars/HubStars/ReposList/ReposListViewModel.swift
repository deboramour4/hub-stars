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
    private var service: GitHubServiceProtocol
    internal var allRepos: [Repo] = []
    private var cellViewModels: [RepoCellViewModel] = []
    
    // MARK: - Typealias
    typealias BooleanClosure = ((Bool) -> (Void))?
    typealias NotifyClosure = (() -> (Void))?
    
    
    // MARK: - Output
    public var onRequest: BooleanClosure = nil
    public var successOnRequest: NotifyClosure = nil
    public var errorOnRequest: NotifyClosure = nil
    public var successOnRefresh: NotifyClosure = nil
    public var titleText: String = "Most starred"
    public var numberOfSections: Int = 1
    public var numberOfRows: Int {
        return allRepos.count
    }
    
    // MARK: - Constructors
    init(_ service: GitHubServiceProtocol = GitHubService()) {
        self.service = service
        requestRepos()
    }
    
    // MARK: - Internal functions
    private func requestRepos() {
        onRequest?(true)
        
        service.getRepos { [weak self] (result) in
            self?.onRequest?(false)

            switch result {
            case .success(let repos):
                self?.allRepos = repos.all

                self?.cellViewModels.removeAll()
                for repo in repos.all {
                    let cellViewModel = RepoCellViewModel(repo: repo)
                    self?.cellViewModels.append(cellViewModel)
                }
                self?.successOnRequest?()
            case .failure(let error):
                print(error.localizedDescription)
                self?.errorOnRequest?()
            }
        }
    }
    
    public func getCellViewModel(for indexPath: IndexPath) -> RepoCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    public func viewDidPullToRefresh() {
        requestRepos()
    }
}
