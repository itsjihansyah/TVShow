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
        let service = MockAPIService()
        let sut = HomeViewModel(service: service)
        
        XCTAssertEqual(sut.viewState, .idle)
    }
    
    func test_init_hasEmptyShows() {
        let service = MockAPIService()
        let sut = HomeViewModel(service: service)
        
        XCTAssertTrue(sut.allShows.isEmpty)
    }
    
    func test_init_hasNoSelectedGenre() {
        let service = MockAPIService()
        let sut = HomeViewModel(service: service)
        
        XCTAssertNil(sut.selectedGenre)
    }
    
    func test_selectGenre_updatesSelectedGenre() {
        let service = MockAPIService()
        let sut = HomeViewModel(service: service)
        
        sut.selectGenre("Drama")
        
        XCTAssertEqual(sut.selectedGenre, "Drama")
    }
    
    func test_selectGenre_nil_clearsSelectedGenre() {
        let service = MockAPIService()
        let sut = HomeViewModel(service: service)
        
        sut.selectGenre("Drama")
        sut.selectGenre(nil)
        
        XCTAssertNil(sut.selectedGenre)
    }
    
    func test_load_success_updatesShows() async {
        let service = MockAPIService()
        service.result = .success(TVShowMockData.shows)
        
        let sut = HomeViewModel(service: service)
        
        await sut.load()
        
        XCTAssertEqual(sut.allShows, TVShowMockData.shows)
        XCTAssertEqual(sut.viewState, .success)
    }
    
    func test_load_failure_setsErrorState() async {
        let service = MockAPIService()
        service.result = .failure(MockError.network)
        
        let sut = HomeViewModel(service: service)
        
        await sut.load()
        
        guard case .error = sut.viewState else {
            XCTFail("Expected error state")
            return
        }
    }
    
    func test_load_success_updatesTopRatedShows() async {
        let service = MockAPIService()
        service.result = .success(TVShowMockData.shows)

        let sut = HomeViewModel(service: service)

        await sut.load()

        XCTAssertEqual(
            sut.topRatedShows,
            TVShowMockData.shows
                .sorted { ($0.rating?.average ?? 0) > ($1.rating?.average ?? 0) }
                .prefix(5)
                .map { $0 }
        )
    }
    
    func test_load_success_updatesGenres() async {
        let service = MockAPIService()
        service.result = .success(TVShowMockData.shows)

        let sut = HomeViewModel(service: service)

        await sut.load()

        XCTAssertEqual(
            sut.genres,
            ["Drama", "Science-Fiction", "Thriller"]
        )
    }
    
    func test_load_success_withEmptyShows_hasEmptyGenres() async {
        let service = MockAPIService()
        service.result = .success([] as [TVShow])

        let sut = HomeViewModel(service: service)

        await sut.load()

        XCTAssertTrue(sut.genres.isEmpty)
    }
}
