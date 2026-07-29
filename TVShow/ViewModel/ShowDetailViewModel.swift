//
//  ShowDetailViewModel.swift
//  TVShow
//
//  Created by Jihan Syahira Adnanda Putri on 29/07/26.
//

import Combine

@MainActor
final class ShowDetailViewModel: ObservableObject {
    let show: TVShow

    init(show: TVShow) {
        self.show = show
    }
}
