//
//  CarouselView.swift
//  TVShow
//
//  Created by Jihan Syahira Adnanda Putri on 29/07/26.
//

import SwiftUI

struct CarouselView: View {
    let shows: [TVShow]
    let refreshID: UUID
    let onShowTap: (TVShow) -> Void

    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var scrollPosition: Int?
    @State private var pendingRecenteringPosition: Int?

    private let cardWidth: CGFloat = 170
    private let cardSpacing: CGFloat = 16
    private let slideDuration: TimeInterval = 0.35
    private let secondsPerSlide: TimeInterval = 4

    private var carouselShows: [TVShow] {
        shows + shows + shows
    }

    var body: some View {
        if shows.count <= 1 {
            singleShowView
        } else {
            carouselView
        }
    }

    private var singleShowView: some View {
        Group {
            if let show = shows.first {
                Button {
                    onShowTap(show)
                } label: {
                    CardView(
                        show: show,
                        refreshID: refreshID,
                        posterWidth: cardWidth
                    )
                }
                .buttonStyle(.plain)
                .accessibilityLabel(show.name)
                .accessibilityHint("Opens show details")
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
    }
    
    private var carouselView: some View {
        VStack(spacing: 24) {
            GeometryReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: cardSpacing) {
                        ForEach(carouselShows.indices, id: \.self) { index in
                            let show = carouselShows[index]
                            Button {
                                onShowTap(show)
                            } label: {
                                CardView(
                                    show: show,
                                    refreshID: refreshID,
                                    posterWidth: cardWidth
                                )
                            }
                            .buttonStyle(.plain)
                            .scrollTransition(.interactive, axis: .horizontal) { content, phase in
                                content.scaleEffect(phase.isIdentity ? 1 : 0.84)
                            }
                            .id(index)
                            .accessibilityLabel(show.name)
                            .accessibilityHint("Opens show details")
                        }
                    }
                    .scrollTargetLayout()
                }
                .contentMargins(
                    carouselSideMargin(
                        containerWidth: proxy.size.width
                    ),
                    for: .scrollContent
                )
                .scrollTargetBehavior(.viewAligned)
                .scrollPosition(id: $scrollPosition)
                .scrollIndicators(.hidden)
            }
            .frame(height: 320)

            indicator
        }
        .onChange(of: scrollPosition) { _, newValue in
            scheduleRecenteringIfNeeded(newValue)
        }
        .onScrollPhaseChange { _, newPhase, _ in
            guard newPhase == .idle,
                  let pendingRecenteringPosition
            else {
                return
            }

            recenterIfNeeded(pendingRecenteringPosition)
        }
        .task(id: shows.map(\.id)) {
            guard shows.count > 1 else {
                return
            }

            await Task.yield()
            guard !Task.isCancelled else { return }
            resetToMiddle()

            while !Task.isCancelled {
                do {
                    try await Task.sleep(for: .seconds(secondsPerSlide))
                } catch {
                    return
                }

                guard !Task.isCancelled else { return }
                guard !reduceMotion, let scrollPosition else { continue }

                withAnimation(
                    .easeInOut(duration: slideDuration)
                ) {
                    self.scrollPosition = scrollPosition + 1
                }
            }
        }
    }


    private var indicator: some View {
        HStack(spacing: 6) {
            ForEach(shows.indices, id: \.self) { index in
                Capsule()
                    .fill(
                        index == currentIndex
                        ? Color.white
                        : Color.white.opacity(0.1)
                    )
                    .frame(
                        width: index == currentIndex ? 18 : 6,
                        height: 6
                    )
            }
        }
    }

    private var currentIndex: Int {
        guard let scrollPosition else {
            return 0
        }

        return scrollPosition % shows.count
    }

    private func resetToMiddle() {
        guard !shows.isEmpty else {
            return
        }

        scrollPosition = shows.count
        pendingRecenteringPosition = nil
    }

    private func scheduleRecenteringIfNeeded(_ position: Int?) {
        guard let position, !shows.isEmpty else {
            return
        }

        let count = shows.count

        if position >= count * 2 || position < count {
            pendingRecenteringPosition = position
        }
    }

    private func recenterIfNeeded(_ position: Int) {
        guard !shows.isEmpty else { return }

        let count = shows.count

        var target = position

        if position >= count * 2 {
            target -= count
        } else if position < count {
            target += count
        }

        guard target != position else {
            return
        }

        var transaction = Transaction()
        transaction.animation = nil

        withTransaction(transaction) {
            scrollPosition = target
        }
        pendingRecenteringPosition = nil
    }

    private func carouselSideMargin(
        containerWidth: CGFloat
    ) -> CGFloat {
        max(
            (containerWidth - cardWidth) / 2,
            16
        )
    }
}
