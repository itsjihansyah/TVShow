//
//  APIService.swift
//  TVShow
//
//  Created by Jihan Syahira Adnanda Putri on 29/07/26.
//

import Foundation

typealias Parameters = [String: String]

struct APIRequest {
    let endpoint: Endpoint
    var params: Parameters = [:]
}

protocol APIServiceProtocol {
    func fetchData<T: Decodable>(request: APIRequest) async throws -> T
}

enum APIServiceError: Error {
    case invalidResponse
}

final class APIService: APIServiceProtocol {
    func fetchData<T: Decodable>(request: APIRequest) async throws -> T {
        fatalError("Not implemented yet")
    }
}
