//
//  HomeView.swift
//  TVShow
//
//  Created by Jihan Syahira Adnanda Putri on 29/07/26.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel: HomeViewModel
    
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    init(service: any APIServiceProtocol = APIService()) {
        _viewModel = StateObject(
            wrappedValue: HomeViewModel(service: service)
        )
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.background
                    .ignoresSafeArea()
                
                VStack(alignment: .leading, spacing: 24) {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("TV Shows")
                            .font(.system(size: 32, weight: .bold))
                            .padding(.horizontal, 16)
                            .padding(.top, 24)
                        
                        genreFilterView
                    }

                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 24) {

                            Text("Top Rated")
                                .font(.system(size: 24, weight: .semibold))
                                .padding(.horizontal, 16)

                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack(spacing: 16) {
                                    switch viewModel.viewState {
                                    case .loading:
                                        ForEach(0..<5, id: \.self) { _ in
                                            CardSkeletonView()
                                        }
                                        
                                    case .success:
                                        ForEach(viewModel.topRatedShows, id: \.id) { show in
                                            CardView(show: show)
                                                .onTapGesture {
                                                    viewModel.selectShow(show)
                                                }
                                        }
                                        
                                    default:
                                        EmptyView()
                                    }
                                }
                                .padding(.horizontal, 16)
                            }

                            Text("Browse")
                                .font(.system(size: 24, weight: .semibold))
                                .padding(.horizontal, 16)

                            LazyVGrid(columns: columns, spacing: 24) {
                                switch viewModel.viewState {
                                case .loading:
                                    ForEach(0..<6, id: \.self) { index in
                                        CardSkeletonView()
                                            .id("skeleton-\(index)")
                                    }
                                    
                                case .success:
                                    ForEach(viewModel.filteredShows, id: \.id) { show in
                                        
                                        CardView(show: show)
                                            .onTapGesture {
                                                viewModel.selectShow(show)
                                            }
                                            .onAppear {
                                                if show.id == viewModel.filteredShows.last?.id {
                                                    Task {
                                                        await viewModel.fetchNextPage()
                                                    }
                                                }
                                            }
                                    }
                                    
                                default:
                                    EmptyView()
                                }
                            }
                            .padding(.horizontal, 16)
                        }
                    }
                }
                
            }
            .navigationBarHidden(true)
            .navigationDestination(item: $viewModel.selectedShow) { show in
                ShowDetailView(show: show)
            }
        }
        .preferredColorScheme(.dark)
        .refreshable {
            await viewModel.load()
        }
        .task {
            await viewModel.load()
        }
    }
}

private extension HomeView {
    var genreFilterView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {

                Chip(
                    name: "All",
                    isSelected: viewModel.selectedGenre == nil
                )
                .onTapGesture {
                    viewModel.selectGenre(nil)
                }

                ForEach(viewModel.genres, id: \.self) { genre in
                    Chip(
                        name: genre,
                        isSelected: viewModel.selectedGenre == genre
                    )
                    .onTapGesture {
                        viewModel.selectGenre(
                            viewModel.selectedGenre == genre ? nil : genre
                        )
                    }
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

#Preview {
    HomeView()
}
