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
        VStack(alignment: .leading) {
            ZStack {
                Color.background
                    .ignoresSafeArea()
                
                ScrollView {
                    ZStack(alignment: .top) {
                        ImageLoader(
                            url: viewModel.show.image.original,
                            width: UIScreen.main.bounds.width,
                            cornerRadius: 0
                        )
                        .offset(y: -UIScreen.main.bounds.height * 0.16)
                        
                        LinearGradient(
                            stops: [
                                .init(color: .clear, location: 0),
                                .init(color: Color.background, location: 0.6)
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .frame(height: 680)
                        
                        VStack(alignment: .leading, spacing: 16) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text(viewModel.show.name)
                                    .font(.system(size: 36))
                                    .fontWeight(Font.Weight.bold)
                                HStack {
                                    HStack(spacing: 4){
                                        Image(systemName: "star.fill")
                                            .imageScale(.small)
                                        Text(viewModel.show.rating?.average?.description ?? "-")
                                            .font(.system(size: 18))
                                    }
                                    
                                    if viewModel.show.premieredText != "" {
                                        Circle()
                                            .frame(width: 4)
                                        
                                        Text(viewModel.show.premieredText)
                                            .font(.system(size: 18))
                                    }
                                }
                                .foregroundStyle(.secondaryApp)
                            }
                            .padding(.horizontal, 16)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 12) {
                                    ForEach(viewModel.show.genres, id: \.self) { genre in
                                        Chip(name: genre)
                                    }
                                }
                                .padding(.horizontal, 16)
                            }
                            
                            ShareLink(
                                item: viewModel.show.url,
                                subject: Text(viewModel.show.name),
                                message: Text(viewModel.show.shareText)
                            ) {
                                ButtonPrimaryView(
                                    title: "Share",
                                    icon: "arrowshape.turn.up.forward.fill"
                                )
                            }
                            .padding(16)
                            
                            Text(viewModel.show.plainSummary)
                                .padding(.horizontal, 16)
                        }
                        .padding(.top, 420)
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
        .preferredColorScheme(.dark)
    }
}
