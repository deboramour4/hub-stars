//
//  GitHubService.swift
//  HubStars
//
//  Created by Debora Moura on 19/06/20.
//  Copyright © 2020 Debora Moura. All rights reserved.
//

import Foundation

// MARK: - GitHubServiceProtocol
protocol GitHubServiceProtocol {
    typealias ReposResult = (Result<Repositories, APIRequester.RequestError>)
    typealias DataResult = (Result<Data, APIRequester.RequestError>)
    
    func getRepos(perPage: Int, page: Int, _ completion: @escaping ((ReposResult) -> Void))
    func getImageData(of repo: Repo, _ completion: @escaping ((DataResult) -> Void))
}

// MARK: - GitHubService
final class GitHubService: GitHubServiceProtocol {
    
    // MARK: - Properties
    private var requester: APIRequesterProtocol
    
    // MARK: - Initializers
    init(_ requester: APIRequesterProtocol = APIRequester()) {
        self.requester = requester
    }
    
    // MARK: - Internal functions
    func getRepos(perPage: Int, page: Int, _ completion: @escaping ((ReposResult) -> Void)) {
        requester.getJSON(endpoint: Endpoint.repos(perPage: perPage, page: page)) { (result: ReposResult) in
            completion(result)
        }
    }
    
    func getImageData(of repo: Repo, _ completion: @escaping ((DataResult) -> Void)) {
        let avatarUrl = repo.owner.avatarURL
        
        requester.getData(endpoint: Endpoint.image(url: avatarUrl)) { (result: DataResult) in
            completion(result)
        }
    }
    
}
