//
//  URLRequest.swift
//  TVShow
//
//  Created by Jihan Syahira Adnanda Putri on 29/07/26.
//

import Foundation

enum URLRequestBuilder {
    static func build(request: APIRequest) throws -> URLRequest {
        fatalError("Not implemented yet")
    }
}

enum URLRequestBuilderError: Error {
    case invalidPath
    case invalidURL
}
