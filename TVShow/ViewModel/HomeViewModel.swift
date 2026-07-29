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

    @Published private(set) var allShows: [TVShow] = []
    @Published private(set) var filteredShows: [TVShow] = []
    @Published private(set) var topRatedShows: [TVShow] = []
    @Published private(set) var genres: [String] = []
    @Published private(set) var viewState: ViewState = .idle
    @Published private(set) var selectedGenre: String?
    @Published var selectedShow: TVShow? = nil

    init(service: APIServiceProtocol) {
        self.service = service
    }
    
    func selectGenre(_ genre: String?) {
        selectedGenre = genre
        applyFilter()
    }
    
    func selectShow(_ show: TVShow) {
        selectedShow = show
    }
    
    func load() async {
        viewState = .loading
        
        do {
            let shows: [TVShow] = try await service.fetchData(
                request: APIRequest(endpoint: .showList)
            )
            
            self.allShows = shows
            collectGenres()
            applyFilter()
            self.viewState = .success
            
        } catch {
            self.viewState = .error(error.localizedDescription)
        }
    }
    
    func applyFilter() {
        if let genre = selectedGenre {
            filteredShows = allShows.filter {
                $0.genres.contains(genre)
            }
        } else {
            filteredShows = allShows
        }

        topRatedShows = filteredShows
            .sorted { ($0.rating?.average ?? 0) > ($1.rating?.average ?? 0) }
            .prefix(5)
            .map { $0 }
    }
    
    func collectGenres() {
        genres = Array(Set(allShows.flatMap(\.genres))).sorted()
    }
}
