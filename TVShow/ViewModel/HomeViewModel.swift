//
//  HomeViewModel.swift
//  TVShow
//
//  Created by Jihan Syahira Adnanda Putri on 29/07/26.
//

import Combine

@MainActor
final class HomeViewModel: ObservableObject {
    private let service: APIServiceProtocol

    @Published private(set) var shows: [TVShow] = []
    @Published private(set) var viewState: ViewState = .idle
    @Published private(set) var selectedGenre: String?

    init(service: APIServiceProtocol) {
        self.service = service
    }
    
    func selectGenre(_ genre: String?) {
        selectedGenre = genre
    }
}
