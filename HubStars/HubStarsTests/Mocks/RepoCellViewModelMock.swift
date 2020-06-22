//
//  RepoCellViewModelMock.swift
//  HubStarsTests
//
//  Created by Debora Moura on 22/06/20.
//  Copyright © 2020 Debora Moura. All rights reserved.
//

import Foundation
import UIKit
@testable import HubStars

// MARK: - RepoCellViewModel
final class RepoCellViewModelMock: RepoCellViewModelProtocol {
    
    
    // MARK: - Properties
    private let repo: Repo
    var delegate: RepoCellViewModelDelegate?
    
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
    init(repo: Repo) {
        self.repo = repo
    }
    
    // MARK: - Public functions
    public func getImageData() {
        if let data = imageData {
            delegate?.successOnRequest(data)
            return
        }
        if let imageData = UIImage.placeholder.pngData() {
            delegate?.successOnRequest(imageData)
        }
    }
}
