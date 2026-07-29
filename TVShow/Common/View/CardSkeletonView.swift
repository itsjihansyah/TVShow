//
//  CardSkeletonView.swift
//  TVShow
//
//  Created by Jihan Syahira Adnanda Putri on 29/07/26.
//

import SwiftUI

struct CardSkeletonView: View {

    var posterWidth: CGFloat = 170

    var body: some View {
        VStack(spacing: 12) {

            RoundedRectangle(cornerRadius: 20)
                .fill(.gray.opacity(0.3))
                .frame(width: posterWidth,
                       height: posterWidth * 1.5)

            RoundedRectangle(cornerRadius: 6)
                .fill(.gray.opacity(0.3))
                .frame(width: posterWidth * 0.8,
                       height: 16)
            
            RoundedRectangle(cornerRadius: 6)
                .fill(.gray.opacity(0.3))
                .frame(width: posterWidth * 0.4,
                       height: 16)
        }
        .shimmer()
    }
}
