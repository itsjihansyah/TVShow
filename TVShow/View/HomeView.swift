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
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.horizontal, 16)
                            .padding(.top, 24)
                        
                        genreFilterView
                    }

                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 24) {

                            Text("Top Rated")
                                .font(.title)
                                .fontWeight(.semibold)
                                .padding(.horizontal, 16)

                            switch viewModel.viewState {
                            case .loading:
                                ScrollView(.horizontal, showsIndicators: false) {
                                    LazyHStack(spacing: 16) {
                                        ForEach(0..<5, id: \.self) { _ in
                                            CardSkeletonView()
                                        }
                                    }
                                    .padding(.horizontal, 16)
                                }

                            case .success:
                                CarouselView(
                                    shows: viewModel.topRatedShows,
                                    refreshID: viewModel.imageRefreshID,
                                    onShowTap: { show in
                                        viewModel.selectShow(show)
                                    }
                                )

                            default:
                                EmptyView()
                            }

                            Text("Browse")
                                .font(.title)
                                .fontWeight(.semibold)
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
                                        
                                        Button {
                                            viewModel.selectShow(show)
                                        } label: {
                                            CardView(
                                                show: show,
                                                refreshID: viewModel.imageRefreshID
                                            )
                                        }
                                        .buttonStyle(.plain)
                                        .accessibilityLabel(show.name)
                                        .accessibilityHint("Opens show details")
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
                
                if case .error(_) = viewModel.viewState {
                    Color.black
                        .opacity(0.5)
                        .ignoresSafeArea()
                    
                    ErrorModalView(
                        retryAction: {
                            Task {
                                await viewModel.load()
                            }
                        }
                    )
                    .transition(.scale.combined(with: .opacity))
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

                Button {
                    viewModel.selectGenre(nil)
                } label: {
                    Chip(
                        name: "All",
                        isSelected: viewModel.selectedGenre == nil
                    )
                }
                .buttonStyle(.plain)
                .accessibilityLabel("All genres")
                .accessibilityHint("Shows every TV show")

                ForEach(viewModel.genres, id: \.self) { genre in
                    Button {
                        viewModel.selectGenre(
                            viewModel.selectedGenre == genre ? nil : genre
                        )
                    } label: {
                        Chip(
                            name: genre,
                            isSelected: viewModel.selectedGenre == genre
                        )
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel(genre)
                    .accessibilityHint("Filters TV shows")
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

#Preview {
    HomeView()
}
