//
//  ViewState.swift
//  TVShow
//
//  Created by Jihan Syahira Adnanda Putri on 29/07/26.
//

enum ViewState: Equatable {
    case idle
    case loading
    case success
    case error(String)
}
