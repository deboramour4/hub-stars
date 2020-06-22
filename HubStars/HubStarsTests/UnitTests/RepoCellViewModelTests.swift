//
//  RepoCellViewModelTests.swift
//  HubStarsTests
//
//  Created by Debora Moura on 20/06/20.
//  Copyright © 2020 Debora Moura. All rights reserved.
//

import XCTest
import Quick
import Nimble
@testable import HubStars

class RepoCellViewModelTests: QuickSpec {
    
    var sut: RepoCellViewModel!
    var gitHubServiceMock: GitHubServiceMock!
    
    override func spec() {
        
        beforeEach {
            self.gitHubServiceMock = GitHubServiceMock()
            
            let mockRepo1 = Repo(id: 99,
                                name: "The best",
                                owner: Owner(login: "myname123", id: 1, avatarURL: "avatarURL"),
                                htmlURL: "URL",
                                stars: 3821)
            
            self.sut = RepoCellViewModel(repo: mockRepo1, service: self.gitHubServiceMock)
        }
        
        afterEach {
            self.gitHubServiceMock = nil
            self.sut = nil
        }
        
        describe("repoCellViewModel tests") {
                
            it("has correct title") {
                expect(self.sut.repoTitleText).to(equal("The best"))
            }
            
            it("has correct username") {
                expect(self.sut.usernameText).to(equal("@myname123"))
            }
            
            it("has correct stars") {
                expect(self.sut.starsCountText).to(equal("★ 3.8k"))
            }
                    
            it("has correct url") {
                expect(self.sut.repoUrlString).to(equal("URL"))
            }
            
//            it("returns correct cellViewModel") {
//                self.sut.successOnRequest = { data in
//                    let mockImage: UIImage = UIImage.placeholder
//                    if let mockData = mockImage.pngData() {
//                        expect(data).to(equal(mockData))
//                    }
//                }
//                self.sut.getImageData()
//            }
        }
    }
}
