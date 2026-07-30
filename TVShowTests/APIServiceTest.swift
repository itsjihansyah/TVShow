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
        
        XCTAssertEqual(show.premieredText, "Premiered on 4/06/2013")
    }
    
    func test_plainSummary_removesHTMLTags() {
        let show = TVShowMockData.shows[0]
        
        XCTAssertEqual(
            show.plainSummary,
            "Under the Dome is the story of a small town that is suddenly and inexplicably sealed off from the rest of the world by an enormous transparent dome."
        )
    }
    
    func test_shareText_containsTitleSummaryAndURL() {
        let show = TVShowMockData.shows[0]

        XCTAssertTrue(show.shareText.contains(show.name))
        XCTAssertTrue(show.shareText.contains(show.plainSummary))
        XCTAssertTrue(show.shareText.contains(show.url.absoluteString))
    }
    
    func test_decode_withNullData_decodesSuccessfully() throws {
        let json = """
        {
            "id": 999,
            "name": "Mystery Show",
            "rating": { "average": null },
            "image": null,
            "genres": [],
            "summary": null,
            "premiered": null,
            "url": "https://www.tvmaze.com/shows/999/mystery-show"
        }
        """.data(using: .utf8)!

        let show = try JSONDecoder().decode(TVShow.self, from: json)

        XCTAssertNil(show.image)
        XCTAssertNil(show.summary)
        XCTAssertNil(show.premiered)
    }

    func test_plainSummary_withNilSummary_returnsEmptyString() {
        let show = TVShowMockData.showWithMissingFields

        XCTAssertEqual(show.plainSummary, "")
    }

    func test_premieredText_withNilPremiered_returnsEmptyString() {
        let show = TVShowMockData.showWithMissingFields

        XCTAssertEqual(show.premieredText, "")
    }

    func test_shareText_withMissingFields_doesNotCrashAndContainsTitleAndURL() {
        let show = TVShowMockData.showWithMissingFields

        XCTAssertTrue(show.shareText.contains(show.name))
        XCTAssertTrue(show.shareText.contains(show.url.absoluteString))
    }
}
