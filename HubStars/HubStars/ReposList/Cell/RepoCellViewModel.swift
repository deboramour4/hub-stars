//
//  RepoCellViewModel.swift
//  HubStars
//
//  Created by Debora Moura on 19/06/20.
//  Copyright © 2020 Debora Moura. All rights reserved.
//

import Foundation

// MARK: - RepoCellViewModel
final class RepoCellViewModel {
    
    // MARK: - Properties
    private let repo: Repo
    private let service: GitHubService
    
    // MARK: - Typealias
    typealias DataClosure = ((Data?) -> (Void))?
    typealias NotifyClosure = (() -> (Void))?
    
    // MARK: - Output
    public var successOnRequest: DataClosure = nil
    public var errorOnRequest: NotifyClosure = nil
    
    public var imageData: Data?

    public var usernameText: String {
        return "@\(repo.owner.login)"
    }
    public var repoTitleText: String {
        return repo.name
    }
    public var starsCountText: String? {
        return "⭐︎ ".appending(repo.stars.thousandFormat)
    }
    public var repoUrlString: String {
           return repo.htmlURL
       }
    
    // MARK: - Constructors
    init(repo: Repo,
         service: GitHubService = GitHubService()) {
        self.repo = repo
        self.service = service
    }
    
    // MARK: - Internal functions
    public func getImageData() {
        if let data = imageData {
            successOnRequest?(data)
            return
        }

        service.getImageData(of: repo) { [weak self] (result) in
            switch result {
            case .success(let data):
                self?.imageData = data
                self?.successOnRequest?(data)
            case .failure(let error):
                print(error.localizedDescription)
                self?.errorOnRequest?()
            }
        }
    }
}

