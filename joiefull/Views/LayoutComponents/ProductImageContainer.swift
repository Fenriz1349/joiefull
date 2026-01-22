//
//  ProductImageContainer.swift
//  joiefull
//
//  Created by Julien Cotte on 19/12/2025.
//

import SwiftUI

/// Image container with overlays (like button + optional share button)
/// Enforces a given aspect ratio based on available width using GeometryReader
struct ProductImageContainer: View {
    let item: Clothing
    var aspectRatio: CGFloat = 1

    // UI state (already computed upstream)
    let displayedLikes: Int
    let isLiked: Bool
    let rating: Double

    // Accessibility
    var basePriority: Double

    // Actions
    var onOpen: (() -> Void)? = nil
    let onLikeTapped: () -> Void
    var onShareTapped: (() -> Void)? = nil
    var onClose: (() -> Void)? = nil

    // Focus (optional, controlled by parent)
    var isSummaryFocused: AccessibilityFocusState<Bool>.Binding? = nil

    private var isDetailView: Bool { onShareTapped != nil }
    private var isCard: Bool { onOpen != nil }

    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            let height = width / aspectRatio
            ZStack(alignment: .bottomTrailing) {
                VStack {
                    ProductImage(imageURL: item.picture.url)
                        .frame(width: width, height: height)
                        .clipped()
                        .accessibilityHidden(true)
                }
                .frame(width: width, height: height)
                .clipShape(RoundedRectangle(cornerRadius: 25))
                ButtonsOverlay(
                    likes: displayedLikes,
                    isLiked: isLiked,
                    onLikeTapped: onLikeTapped,
                    onShareTapped: onShareTapped,
                    onClose: onClose
                )
            }
        }
        .aspectRatio(aspectRatio, contentMode: .fit)
        .accessibilityRepresentation {
            ZStack(alignment: .center) {
                let summary = RoundedRectangle(cornerRadius: 25)
                    .fill(.clear)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .contentShape(RoundedRectangle(cornerRadius: 25))
                    .accessibilityElement()
                    .accessibilityLabel(
                        AccessibilityHandler.Clothing.itemSummary(
                            itemName: item.name,
                            imageDescription: isDetailView ? nil : item.picture.description,
                            itemDescription: isDetailView ? item.descriptionText : nil,
                            price: item.price,
                            originalPrice: item.originalPrice,
                            rating: rating
                        )
                    )
                    .accessibilityAddTraits(isCard ? .isButton : [])
                    .accessibilityHint(isCard ? AccessibilityHandler.Clothing.hintCard : "")
                    .accessibilityAction { onOpen?() }
                    .accessibilitySortPriority(basePriority + 3)

                if let isSummaryFocused {
                    summary.accessibilityFocused(isSummaryFocused)
                } else {
                    summary
                }
            }
            .overlay(alignment: .topLeading) {
                // Actions
                if isDetailView, let onClose {
                    CloseButton(action: onClose)
                        .frame(width: 34, height: 34)
                        .contentShape(Circle())
                        .padding(22)
                        .accessibilitySortPriority(basePriority + 2)
                }
            }
            .overlay(alignment: .topTrailing) {
                if isDetailView, let onShareTapped  {
                    ShareButton(action: onShareTapped)
                        .frame(width: 34, height: 34)
                        .contentShape(Circle())
                        .padding(22)
                        .accessibilitySortPriority(basePriority + 1.5)
                }
            }
            .overlay(alignment: .bottomTrailing) {
                LikeButton(
                    likes: displayedLikes,
                    isLiked: isLiked,
                    action: onLikeTapped
                )
                .accessibilitySortPriority(basePriority)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                .padding(16)
            }
        }
    }
}

#Preview("Card – portrait (rectangulaire)") {
    ProductImageContainer(
        item: PreviewItems.item,
        aspectRatio: 3/4,
        displayedLikes: 15,
        isLiked: true,
        rating: 4.1,
        basePriority: 10,
        onLikeTapped: {}
    )
    .environmentObject(PreviewContainer.containerViewModel)
    .padding()
}

#Preview("Detail – iPhone") {
    ProductImageContainer(
        item: PreviewItems.item,
        displayedLikes: 15,
        isLiked: true,
        rating: 4.1,
        basePriority: 10,
        onLikeTapped: {},
        onShareTapped: {},
        onClose: {}
    )
    .environmentObject(PreviewContainer.containerViewModel)
    .padding()
}

#Preview("Detail – iPhone paysage (carré)") {
    ProductImageContainer(
        item: PreviewItems.item,
        displayedLikes: 15,
        isLiked: true,
        rating: 4.1,
        basePriority: 10,
        onLikeTapped: {},
        onShareTapped: {},
        onClose: {}
    )
    .environmentObject(PreviewContainer.containerViewModel)
    .frame(width: 350) // simulated landscape Iphone width
    .padding()
}

#Preview("Detail – iPad split / paysage (rectangulaire)") {
    ProductImageContainer(
        item: PreviewItems.item,
        displayedLikes: 15,
        isLiked: true,
        rating: 4.1,
        basePriority: 10,
        onLikeTapped: {},
        onShareTapped: {},
        onClose: {}
    )
    .environmentObject(PreviewContainer.containerViewModel)
    .frame(width: 500) // simulated portrait Ipad width
    .padding()
}
