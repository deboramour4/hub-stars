//
//  RepoCellViewModel.swift
//  HubStars
//
//  Created by Debora Moura on 19/06/20.
//  Copyright © 2020 Debora Moura. All rights reserved.
//

import Foundation

// MARK: - RepoCellViewModelProtocol
protocol RepoCellViewModelProtocol {
    var delegate: RepoCellViewModelDelegate? { get set }
    var imageData: Data? { get }
    var usernameText: String { get }
    var repoTitleText: String { get }
    var starsCountText: String? { get }
    var repoUrlString: String { get }
    func getImageData()
}

// MARK: - RepoCellViewModelDelegate
protocol RepoCellViewModelDelegate: class {
    func successOnRequest(_ imageData: Data)
    func errorOnRequest()
}
    
// MARK: - RepoCellViewModel
final class RepoCellViewModel: RepoCellViewModelProtocol {
    
    // MARK: - Properties
    private let repo: Repo
    private let service: GitHubServiceProtocol
    weak var delegate: RepoCellViewModelDelegate?
        
    // MARK: - Output    
    public var imageData: Data?

    public var usernameText: String {
        return "@\(repo.owner.login)"
    }
    public var repoTitleText: String {
        return repo.name
    }
    public var starsCountText: String? {
        return "★ ".appending(repo.stars.thousandFormat)
    }
    public var repoUrlString: String {
       return repo.htmlURL
   }
    
    // MARK: - Initializers
    init(repo: Repo,
         service: GitHubServiceProtocol = GitHubService()) {
        self.repo = repo
        self.service = service
    }
    
    // MARK: - Public functions
    public func getImageData() {
        if let data = imageData {
            delegate?.successOnRequest(data)
            return
        }

        service.getImageData(of: repo) { [weak self] (result) in
            switch result {
            case .success(let data):
                self?.imageData = data
                self?.delegate?.successOnRequest(data)
            case .failure(let error):
                print(error.localizedDescription)
                self?.delegate?.errorOnRequest()
            }
        }
    }
}
