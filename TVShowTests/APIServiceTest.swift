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
}
