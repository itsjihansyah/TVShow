//
//  HomeViewModel.swift
//  TVShow
//
//  Created by Jihan Syahira Adnanda Putri on 29/07/26.
//

import Combine
import Foundation

@MainActor
final class HomeViewModel: ObservableObject {
    private let service: APIServiceProtocol

    @Published private(set) var shows: [TVShow] = []
    @Published private(set) var topRatedShows: [TVShow] = []
    @Published private(set) var viewState: ViewState = .idle
    @Published private(set) var selectedGenre: String?

    init(service: APIServiceProtocol) {
        self.service = service
    }
    
    func selectGenre(_ genre: String?) {
        selectedGenre = genre
    }
    
    func load() async {
        viewState = .loading
        
        do {
            let shows: [TVShow] = try await service.fetchData(
                request: APIRequest(endpoint: .showList)
            )
            
            self.shows = shows
            self.topRatedShows = shows
                .sorted {
                    ($0.rating?.average ?? 0) >
                    ($1.rating?.average ?? 0)
                }
                .prefix(5)
                .map { $0 }
            self.viewState = .success
            
        } catch {
            self.viewState = .error(error.localizedDescription)
        }
    }
}
