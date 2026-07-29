//
//  Data.swift
//  TVShow
//
//  Created by Jihan Syahira Adnanda Putri on 29/07/26.
//

import Foundation

struct TVShow : Codable {
    let id: String
    let title: String
    let rating: Rating?
    let image: ShowImage
    let genres: [String]
    let summary: String
    let premiered: Date
}

struct Rating : Codable {
    let average: Double
}

struct ShowImage: Codable {
    let medium: URL
    let original: URL
}
