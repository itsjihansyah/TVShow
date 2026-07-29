//
//  ShowDetailViewModel.swift
//  TVShow
//
//  Created by Jihan Syahira Adnanda Putri on 29/07/26.
//

import Combine

@MainActor
final class ShowDetailViewModel: ObservableObject {
    private let service: APIServiceProtocol
    var show: TVShow
    
    init(
        show: TVShow,
        showService: any APIServiceProtocol = APIService()
    ) {
        self.show = show
        self.service = showService
    }
}
