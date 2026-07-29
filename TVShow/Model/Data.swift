//
//  Data.swift
//  TVShow
//
//  Created by Jihan Syahira Adnanda Putri on 29/07/26.
//

import Foundation

struct TVShow : Codable, Equatable {
    let id: Int
    let name: String
    let rating: Rating?
    let image: ShowImage
    let genres: [String]
    let summary: String
    let premiered: Date
}

struct Rating : Codable, Equatable {
    let average: Double?
}

struct ShowImage: Codable, Equatable {
    let medium: URL
    let original: URL
}
