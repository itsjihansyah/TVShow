//
//  URLRequestTest.swift
//  TVShow
//
//  Created by Jihan Syahira Adnanda Putri on 29/07/26.
//

import XCTest
@testable import TVShow

final class URLRequestBuilderTests: XCTestCase {
    func test_buildRequest_createsCorrectURL() throws {

        let request = APIRequest(
            endpoint: .showList
        )

        let urlRequest = try URLRequestBuilder.build(
            request: request
        )

        XCTAssertEqual(
            urlRequest.url?.absoluteString,
            "https://api.tvmaze.com/shows"
        )
    }
}
