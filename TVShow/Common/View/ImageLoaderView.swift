//
//  ImageLoader.swift
//  TVShow
//
//  Created by Jihan Syahira Adnanda Putri on 29/07/26.
//

import SwiftUI

struct ImageLoader: View {
    let url: URL?
    var width: CGFloat
    var aspectRatio: CGFloat = 2 / 3
    var cornerRadius: CGFloat = 20
    var imagePlaceholder: String = "photo"
    var imageSize: Double = 20

    @State private var imageID = UUID()
    @State private var retryCount = 0

    var body: some View {
        if let url {
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(.gray.opacity(0.2))

                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .onAppear {
                            retryCount = 0
                        }

                case .failure:
                    placeholder
                        .task(id: imageID) {
                            guard retryCount < 3 else { return }

                            retryCount += 1

                            try? await Task.sleep(for: .seconds(1))

                            imageID = UUID()
                        }

                @unknown default:
                    EmptyView()
                }
            }
            .id(imageID)
            .frame(width: width, height: width / aspectRatio)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        } else {
            placeholder
        }
        
    }
    
    private var placeholder: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(.secondaryApp.opacity(0.2))
            .overlay {
                Image(systemName: imagePlaceholder)
                    .font(.largeTitle)
                    .foregroundStyle(.secondary)
            }
            .frame(width: width, height: width / aspectRatio)
            .preferredColorScheme(.dark)
    }
}

