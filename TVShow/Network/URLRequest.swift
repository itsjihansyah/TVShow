//
//  URLRequest.swift
//  TVShow
//
//  Created by Jihan Syahira Adnanda Putri on 29/07/26.
//

import Foundation

enum URLRequestBuilder {
    static func build(request: APIRequest) throws -> URLRequest {
        guard var urlComponents = URLComponents(string: request.endpoint.fullpath) else {
            throw URLRequestBuilderError.invalidPath
        }
        
        if !request.params.isEmpty {
            urlComponents.queryItems = buildQueryParams(request.params)
        }
        
        guard let url = urlComponents.url else {
            throw URLRequestBuilderError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.setValue(
            "application/json",
            forHTTPHeaderField: "Accept"
        )
        return request
    }
    
    private static func buildQueryParams(_ params: Parameters) -> [URLQueryItem] {
        params.map {
            URLQueryItem(
                name: $0.key,
                value: $0.value
            )
        }
    }
}

enum URLRequestBuilderError: Error {
    case invalidPath
    case invalidURL
}
