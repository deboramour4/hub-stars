//
//  RepositoriesViewModelMock.swift
//  HubStarsTests
//
//  Created by Debora Moura on 22/06/20.
//  Copyright © 2020 Debora Moura. All rights reserved.
//

import Foundation
@testable import HubStars

final class RepositoriesViewModelMock: RepositoriesViewModelProtocol {
    
    
    var delegate: RepositoriesViewModelDelegate?
    var topButtonTitle: String = "↑ Back to top"
    var titleText: String = "Title page"
    var numberOfSections: Int = 1
    var topButtonIsHiddenInitialValue: Bool
    var numberOfRows: Int {
        mockReposCellViewModels.count
    }
    
    private var mockReposCellViewModels: [RepoCellViewModelProtocol]
    
    init(isEmpty: Bool, hasTopButton: Bool = false) {
        let owner = Owner(login: "username", id: 0, avatarURL: "")
        var mockRepos: [Repo]
        if isEmpty {
            mockRepos = [Repo]()
        } else {
            mockRepos = [
                Repo(id: 0, name: "swift-tricks", owner: owner, htmlURL: "url_1", stars: 543210),
                Repo(id: 1, name: "i-love-swift", owner: owner, htmlURL: "url_2", stars: 43215),
                Repo(id: 2, name: "ios-for-all", owner: owner, htmlURL: "url_3", stars: 3215),
                Repo(id: 3, name: "swifting", owner: owner, htmlURL: "url_4", stars: 630),
                Repo(id: 4, name: "swift_tests", owner: owner, htmlURL: "url_5", stars: 15)
            ]
        }
        mockReposCellViewModels = mockRepos.map { repo in
            RepoCellViewModelMock(repo: repo)
        }
        topButtonIsHiddenInitialValue = !hasTopButton
        if hasTopButton {
            mockReposCellViewModels.append(contentsOf: mockReposCellViewModels)
        }
    }
    
    func getCellViewModel(for indexPath: IndexPath) -> RepoCellViewModelProtocol? {
        if indexPath.row >= mockReposCellViewModels.count {
            return nil
        }
        return mockReposCellViewModels[indexPath.row]
    }
    
    func viewDidPullToRefresh() {}
    
    func viewDidTapTryAgain() { }
    
    func viewWillDisplayCell(at indexPath: IndexPath) { }

    
    func isEndOfList(_ indexPath: IndexPath) -> Bool {
        if mockReposCellViewModels.isEmpty {
            return true
        }
        return indexPath.row >= mockReposCellViewModels.count-1
    }
}
