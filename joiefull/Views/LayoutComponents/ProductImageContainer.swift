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
    @EnvironmentObject private var container: ClothingContainerViewModel
    let item: Clothing
    var aspectRatio: CGFloat = 1
    let likes: Int
    let isLiked: Bool

    // Accessibility
    var basePriority: Double
    @AccessibilityFocusState private var focusOnSummary: Bool
    
    // Actions
    var onOpen: (() -> Void)? = nil
    let onLikeTapped: () -> Void
    var onShareTapped: (() -> Void)? = nil
    var onClose: (() -> Void)? = nil
    
    var isDetailView: Bool { onShareTapped != nil }

    var isCard: Bool { onOpen != nil }

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
                    likes: likes,
                    isLiked: isLiked,
                    onLikeTapped: onLikeTapped,
                    onShareTapped: onShareTapped,
                    onClose: onClose
                )
            }
        }
        .aspectRatio(aspectRatio, contentMode: .fit)
        .accessibilityRepresentation {
            ZStack(alignment: .center){
                // Summary (single VO stop)
                RoundedRectangle(cornerRadius: 25)
                    .fill(.clear)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .contentShape(RoundedRectangle(cornerRadius: 25))
                    .accessibilityElement()
                    .accessibilityLabel(
                        AccessibilityHandler.Clothing.itemSummary(
                            itemName: item.name,
                            imageDescription: isDetailView ? nil :item.picture.description,
                            itemDescription: isDetailView ? item.descriptionText : nil,
                            price: item.price,
                            originalPrice: item.originalPrice,
                            rating: container.getCalculatedRating(item)
                        )
                    )
                    .accessibilityAddTraits(isCard ? .isButton : [])
                    .accessibilityAction { onOpen?() }
                    .accessibilityFocused($focusOnSummary)
                    .accessibilitySortPriority(basePriority + 3)
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
                if isDetailView {
                    ShareButton(action: { container.isShareComposerPresented = true })
                        .frame(width: 34, height: 34)
                        .contentShape(Circle())
                        .padding(22)
                        .accessibilitySortPriority(basePriority + 1.5)
                }
            }
            .overlay(alignment: .bottomTrailing) {
                LikeButton(
                    likes: container.getActualLikes(for: item),
                    isLiked: container.isLiked(item),
                    action: { container.toggleLike(for: item) }
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
        likes: 15,
        isLiked: true,
        basePriority: 10,
        onLikeTapped: {}
    )
    .environmentObject(PreviewContainer.containerViewModel)
    .padding()
}

#Preview("Detail – iPhone") {
    ProductImageContainer(
        item: PreviewItems.item,
        likes: 15,
        isLiked: true,
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
        likes: 15,
        isLiked: true,
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
        likes: 15,
        isLiked: true,
        basePriority: 10,
        onLikeTapped: {},
        onShareTapped: {},
        onClose: {}
    )
    .environmentObject(PreviewContainer.containerViewModel)
    .frame(width: 500) // simulated portrait Ipad width
    .padding()
}
