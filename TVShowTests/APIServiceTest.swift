//
//  APIServiceTest.swift
//  TVShow
//
//  Created by Jihan Syahira Adnanda Putri on 29/07/26.
//

import XCTest
@testable import TVShow

@MainActor
final class APIServiceTests: XCTestCase {
    func test_fetchData_success_decodesResponse() async throws {
        let service = APIService()
        
        let request = APIRequest(
            endpoint: .showList
        )
        
        let shows: [TVShow] = try await service.fetchData(
            request: request
        )
        
        XCTAssertFalse(shows.isEmpty)
    }
    
    func test_premieredText_formatsDate() {
        let show = TVShowMockData.shows[0]
        
        XCTAssertEqual(show.premieredText, "24/06/2013")
    }
    
    func test_plainSummary_removesHTMLTags() {
        let show = TVShowMockData.shows[0]
        
        XCTAssertEqual(
            show.plainSummary,
            "Under the Dome is the story of a small town that is suddenly and inexplicably sealed off from the rest of the world by an enormous transparent dome."
        )
    }
}
