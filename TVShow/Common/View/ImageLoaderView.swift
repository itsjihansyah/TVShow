//
//  ImageLoader.swift
//  TVShow
//
//  Created by Jihan Syahira Adnanda Putri on 29/07/26.
//

import SwiftUI

struct ImageLoader: View {
    let url: URL?
    var refreshID: UUID? = nil
    var width: CGFloat
    var aspectRatio: CGFloat = 2 / 3
    var cornerRadius: CGFloat = 20
    var imagePlaceholder: String = "photo"
    var imageSize: Double = 20

    @State private var imageID = UUID()
    @State private var retryCount = 0

    private let maxRetries = 3

    var body: some View {
        Group {
            if let url {
                AsyncImage(url: url) { phase in
                    switch phase {

                    case .empty:
                        loadingPlaceholder

                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .onAppear {
                                retryCount = 0
                            }

                    case .failure:
                        Group {
                            if retryCount < maxRetries {
                                loadingPlaceholder
                            } else {
                                placeholder
                            }
                        }
                        .task(id: retryCount) {
                            guard retryCount < maxRetries else {
                                return
                            }

                            retryCount += 1

                            try? await Task.sleep(for: .seconds(1))

                            imageID = UUID()
                        }

                    @unknown default:
                        EmptyView()
                    }
                }
                .id(imageID)

            } else {
                placeholder
            }
        }
        .frame(width: width, height: width / aspectRatio)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        .task(id: refreshID) {
            retryCount = 0
            imageID = UUID()
        }
    }

    private var loadingPlaceholder: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(.gray.opacity(0.2))
            .shimmer()
    }

    private var placeholder: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(.secondaryApp.opacity(0.2))
            .overlay {
                Image(systemName: imagePlaceholder)
                    .font(.system(size: imageSize))
                    .foregroundStyle(.secondary)
            }
    }
}
