//
//  GitHubServiceMock.swift
//  HubStarsTests
//
//  Created by Debora Moura on 20/06/20.
//  Copyright © 2020 Debora Moura. All rights reserved.
//

import Foundation
import UIKit
@testable import HubStars

final public class GitHubServiceMock: GitHubServiceProtocol {
    
    public func getRepos(perPage: Int, page: Int, _ completion: @escaping ((GitHubServiceMock.ReposResult) -> Void)) {
        let mockOwner = Owner(login: "username",
                              id: 0,
                              avatarURL: "")
        let mockRepo1 = Repo(id: 0,
                             name: "Repo 1",
                             owner: mockOwner,
                             htmlURL: "",
                             stars: 920)
        let mockRepo2 = Repo(id: 1,
                            name: "Repo 2",
                            owner: mockOwner,
                            htmlURL: "",
                            stars: 12345)

        let mockRepos = Repositories(totalCount: 10,
                                     incompleteResults: false,
                                     all: [mockRepo1, mockRepo2])

        completion(.success(mockRepos))
    }
    public func getImageData(of repo: Repo, _ completion: @escaping ((GitHubServiceMock.DataResult) -> Void)) {
        let mockImage: UIImage = UIImage.placeholder
        if let mockData = mockImage.pngData() {
            completion(.success(mockData))
        }
    }
}
