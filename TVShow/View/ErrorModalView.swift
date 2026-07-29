//
//  ErrorModalView.swift
//  TVShow
//
//  Created by Jihan Syahira Adnanda Putri on 29/07/26.
//

import SwiftUI

struct ErrorModalView: View {
    @Environment(\.dismiss) private var dismiss
    let retryAction: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "exclamationmark.circle.fill")
                .font(.system(size: 48, weight: .bold))
                .foregroundStyle(.white)

            VStack(spacing: 8) {
                Text("Something Went Wrong")
                    .font(.system(size: 22, weight: .bold))

                Text("Failed to load the data.\nPlease try again!")
                    .font(.system(size: 16))
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }

            Divider()
                .overlay(.white.opacity(0.2))

            Button {
                dismiss()
                retryAction()
            } label: {
                ButtonPrimaryView(title: "Try Again")
            }
        }
        .padding(24)
        .background {
            if #available(iOS 26.0, *) {
                RoundedRectangle(cornerRadius: 32)
                    .glassEffect(
                        .regular,
                        in: RoundedRectangle(cornerRadius: 32)
                    )
            } else {
                RoundedRectangle(cornerRadius: 32)
                    .fill(.ultraThinMaterial)
            }
        }
        .padding(.horizontal, 32)
    }
}
