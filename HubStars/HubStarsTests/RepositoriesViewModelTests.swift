//
//  HubStarsTests.swift
//  HubStarsTests
//
//  Created by Debora Moura on 19/06/20.
//  Copyright © 2020 Debora Moura. All rights reserved.
//

import Quick
import Nimble
@testable import HubStars

class RepositoriesViewModelTests: QuickSpec {

    var sut: RepositoriesViewModel!
    var gitHubServiceMock: GitHubServiceMock!
    
    override func spec() {
        
        beforeEach {
            self.gitHubServiceMock = GitHubServiceMock()
            self.sut = RepositoriesViewModel(self.gitHubServiceMock)
        }
        
        afterEach {
            self.gitHubServiceMock = nil
            self.sut = nil
        }
        
        describe("repositoriesViewModel tests") {
                
            it("has correct title") {
                expect(self.sut.titleText).to(equal(AppKeys.Repositories.title.localized))
            }
            
            it("has correct nuberOfSection") {
                expect(self.sut.numberOfSections).to(equal(1))
            }
            
            it("has correct numberOfRows") {
                expect(self.sut.numberOfRows).to(equal(10))
            }
                    
            it("has correct countOfRepos") {
                expect(self.sut.currentCountOfRepos).to(equal(2))
            }
            
            it("returns correct getCellViewModel") {
                let vm = self.sut.getCellViewModel(for: IndexPath(row: 1, section: 0))
                expect(vm?.repoTitleText).to(equal("Repo 2"))
                expect(vm?.usernameText).to(equal("@username"))
                expect(vm?.starsCountText).to(equal("★ 12.3k"))
                expect(vm?.repoUrlString).to(equal(""))
            }
            it("updates repos correctly") {
                self.sut.viewDidShowAllRepos()
                expect(self.sut.currentCountOfRepos).to(equal(4))
                
                var vm = self.sut.getCellViewModel(for: IndexPath(row: 3, section: 0))
                expect(vm?.repoTitleText).to(equal("Repo 2"))
                
                self.sut.viewDidTapTryAgain()
                self.sut.viewDidTapTryAgain()
                expect(self.sut.currentCountOfRepos).to(equal(8))
                
                vm = self.sut.getCellViewModel(for: IndexPath(row: 4, section: 0))
                expect(vm?.repoTitleText).to(equal("Repo 1"))
            }
            it("refreshes repos correctly") {
                self.sut.viewDidPullToRefresh()
                expect(self.sut.currentCountOfRepos).to(equal(2))
                
                let vm = self.sut.getCellViewModel(for: IndexPath(row: 0, section: 0))
                expect(vm?.repoTitleText).to(equal("Repo 1"))
            }
            it("returns correct indexpaths") {
                self.sut.successOnRequest = { indexpaths in
                    expect(indexpaths).notTo(beNil())
                    expect(self.sut.currentCountOfRepos).to(equal(2))
               }
            }
        }
    }
}
