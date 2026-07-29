//
//  ShowDetailView.swift
//  TVShow
//
//  Created by Jihan Syahira Adnanda Putri on 29/07/26.
//

import SwiftUI

struct ShowDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: ShowDetailViewModel
    
    init(show: TVShow) {
        _viewModel = StateObject(wrappedValue: ShowDetailViewModel(show: show))
    }
    
    var body: some View {
        Text("Detail View of \(viewModel.show.name)")
    }
}
