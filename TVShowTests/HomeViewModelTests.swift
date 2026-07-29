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
    let mockService = MockAPIService()
    
    func test_init_hasIdleState() {
        let sut = HomeViewModel(service: mockService)

        XCTAssertEqual(sut.viewState, .idle)
    }

    func test_init_hasEmptyShows() {
        let sut = HomeViewModel(service: mockService)

        XCTAssertTrue(sut.shows.isEmpty)
    }

    func test_init_hasNoSelectedGenre() {
        let sut = HomeViewModel(service: mockService)

        XCTAssertNil(sut.selectedGenre)
    }
    
    func test_selectGenre_updatesSelectedGenre() {
        let sut = HomeViewModel(service: mockService)

        sut.selectGenre("Drama")

        XCTAssertEqual(sut.selectedGenre, "Drama")
    }
    
    func test_selectGenre_nil_clearsSelectedGenre() {
        let sut = HomeViewModel(service: mockService)

        sut.selectGenre("Drama")
        sut.selectGenre(nil)

        XCTAssertNil(sut.selectedGenre)
    }
}
