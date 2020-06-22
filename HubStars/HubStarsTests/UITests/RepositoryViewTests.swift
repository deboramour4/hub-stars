//
//  RepositoryViewTests.swift
//  HubStarsTests
//
//  Created by Debora Moura on 22/06/20.
//  Copyright © 2020 Debora Moura. All rights reserved.
//

import XCTest
import FBSnapshotTestCase
@testable import HubStars

class RepositoriesViewUITests: FBSnapshotTestCase {

    var sut: RepositoriesViewController!
    var mockViewModel: RepositoriesViewModelMock!

    override func setUp() {
        super.setUp()
        mockViewModel = RepositoriesViewModelMock(isEmpty: false)
        sut = RepositoriesViewController(viewModel: mockViewModel)
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        mockViewModel = nil
    }

    func test_repository_view_empty() {
        mockViewModel = RepositoriesViewModelMock(isEmpty: true)
        sut = RepositoriesViewController(viewModel: mockViewModel)
        FBSnapshotVerifyViewController(sut)
    }

    func test_repository_view_filled() {
        FBSnapshotVerifyViewController(sut)
    }
    
    func test_repository_view_filled_with_backToTop() {
        mockViewModel = RepositoriesViewModelMock(isEmpty: false, hasTopButton: true)
        sut = RepositoriesViewController(viewModel: mockViewModel)
        FBSnapshotVerifyViewController(sut)
    }
}
