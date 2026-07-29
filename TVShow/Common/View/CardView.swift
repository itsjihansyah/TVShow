//
//  CardView.swift
//  TVShow
//
//  Created by Jihan Syahira Adnanda Putri on 29/07/26.
//

import SwiftUI

struct CardView: View {
    let show: TVShow
    let refreshID: UUID
    
    var posterWidth: CGFloat = 170
    var fontSize: CGFloat = 16
    var fontWeight: Font.Weight = .semibold
    var cornerRadius: CGFloat = 20

    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            ImageLoader(
                url: show.image.medium,
                refreshID: refreshID,
                width: posterWidth,
                cornerRadius: cornerRadius
            )

            VStack(alignment: .center, spacing: 6) {
                Text(show.name)
                    .font(.system(size: fontSize, weight: fontWeight))
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .frame(width: posterWidth, alignment: .center)
                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .font(.system(size: 12))
                    Text(show.rating?.average?.description ?? "-")
                        .font(.system(size: 14))
                }
                .foregroundStyle(.secondaryApp)
            }
        }
        .preferredColorScheme(.dark)
    }
}
