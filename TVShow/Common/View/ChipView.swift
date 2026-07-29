//
//  ChipView.swift
//  TVShow
//
//  Created by Jihan Syahira Adnanda Putri on 29/07/26.
//

import SwiftUI

struct Chip: View {
    let title: String
    var isSelected: Bool = false

    var body: some View {
        if #available(iOS 26.0, *) {
            Text(title)
                .font(.system(size: 18))
                .foregroundStyle(.white)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background {
                    if isSelected {
                        Capsule()
                            .fill(.ultraThinMaterial)
                    }
                }
                .clipShape(Capsule())
                .glassEffect()
        } else {
            Text(title)
                .font(.system(size: 18))
                .foregroundStyle(.white)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(
                    Capsule()
                        .fill(isSelected ? .ultraThickMaterial : .ultraThinMaterial)
                )
        }
    }
}
