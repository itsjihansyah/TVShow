//
//  Data.swift
//  TVShow
//
//  Created by Jihan Syahira Adnanda Putri on 29/07/26.
//

import Foundation

struct TVShow : Codable, Equatable, Hashable {
    let id: Int
    let name: String
    let rating: Rating?
    let image: ShowImage?
    let genres: [String]
    let summary: String?
    let premiered: Date?
    let url: URL
}

struct Rating : Codable, Equatable, Hashable{
    let average: Double?
}

struct ShowImage: Codable, Equatable, Hashable {
    let medium: URL
    let original: URL
}

extension TVShow {
    var premieredText: String {
        guard let premiered else {
            return ""
        }
        
        return "Premiered on " + premiered.formatted(
            .dateTime
                .day(.twoDigits)
                .month(.twoDigits)
                .year()
        )
    }
    
    var plainSummary: String {
        summary?
            .replacingOccurrences(
                of: "<[^>]+>",
                with: "",
                options: .regularExpression
            ) ?? ""
    }
    
    var shareText: String {
            """
            📺 \(name)
            
            \(plainSummary)
            
            Learn more:
            \(url.absoluteString)
            """
    }
}
