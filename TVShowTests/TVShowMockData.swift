//
//  TVShowMockData.swift
//  TVShow
//
//  Created by Jihan Syahira Adnanda Putri on 29/07/26.
//

import Foundation
@testable import TVShow

enum TVShowMockData {
    static let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter
        }()

    static let shows: [TVShow] = [
        TVShow(
            id: 1,
            name: "Under the Dome",
            rating: Rating(
                average: 6.6
            ),
            image: ShowImage(
                medium: URL(string: "https://static.tvmaze.com/uploads/images/medium_portrait/610/1525272.jpg")!,
                original: URL(string: "https://static.tvmaze.com/uploads/images/original_untouched/610/1525272.jpg")!
            ),
            genres: [
                "Drama",
                "Science-Fiction",
                "Thriller"
            ],
            summary: """
            <p><b>Under the Dome</b> is the story of a small town that is suddenly \
            and inexplicably sealed off from the rest of the world by an enormous \
            transparent dome.</p>
            """,
            premiered: dateFormatter.date(from: "2013-06-24")!,
            url: URL(string: "https://www.tvmaze.com/shows/1/under-the-dome")!
        )
    ]
}
