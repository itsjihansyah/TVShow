//
//  HomeViewModelTests.swift
//  TVShowTests
//
//  Created by Jihan Syahira Adnanda Putri on 29/07/26.
//

import XCTest
@testable import TVShow

@MainActor
final class HomeViewModelTests: XCTestCase {
    func test_init_hasIdleState() {
        let sut = HomeViewModel(service: MockAPIService())

        XCTAssertEqual(sut.viewState, .idle)
    }

    func test_init_hasEmptyShows() {
        let sut = HomeViewModel(service: MockAPIService())

        XCTAssertTrue(sut.shows.isEmpty)
    }

    func test_init_hasNoSelectedGenre() {
        let sut = HomeViewModel(service: MockAPIService())

        XCTAssertNil(sut.selectedGenre)
    }
}
