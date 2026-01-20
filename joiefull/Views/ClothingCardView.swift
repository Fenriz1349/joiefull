//
//  ClothingCardView.swift
//  joiefull
//
//  Created by Julien Cotte on 18/12/2025.
//

import SwiftUI

/// Displays a compact card representation of a clothing item in a list or grid
/// Shows the product image, likes count, and essential information with optional selection state
struct ClothingCardView: View {
    @EnvironmentObject private var container: ClothingContainerViewModel
    let item: Clothing
    let isSelected: Bool
    // Used to order VO priority in the list
    let basePriority: Double
    let onOpen: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .bottomTrailing) {
                ProductImageContainer(imageURL: item.picture.url, aspectRatio: 3 / 4)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(isSelected ? Color.accentColor : .clear, lineWidth: 3)
                    )
                ButtonsOverlay(
                    likes: container.getActualLikes(for: item),
                    isLiked: container.isLiked(item),
                    onLikeTapped: { container.toggleLike(for: item) }
                )
            }
            DescriptionRow(rating: container.getCalculatedRating(item), item: item)
                .foregroundStyle(isSelected ? Color.accentColor : .primary)
        }
        // ACCESSIBILITY - Read Card as one then the like button
        .accessibilityRepresentation {
            VStack(alignment: .trailing, spacing: 0) {
                VStack(alignment: .leading, spacing: 8) {                ProductImageContainer(imageURL: item.picture.url, aspectRatio: 3 / 4)
                    DescriptionRow(rating: container.getCalculatedRating(item), item: item)
                }
                .accessibilityElement()
                .accessibilityAddTraits(.isButton)
                .accessibilityLabel(AccessibilityHandler.ClothingCard.fullLabel(
                    itemName: item.name,
                    imageDescription: item.picture.description,
                    price: item.price,
                    originalPrice: item.originalPrice,
                    rating: container.getCalculatedRating(item),
                    category: item.category.title)
                )
                .accessibilityHint(AccessibilityHandler.ClothingCard.hint)
                .accessibilityAction { onOpen() }
                .accessibilitySortPriority(basePriority + 1)

                ButtonsOverlay(
                    likes: container.getActualLikes(for: item),
                    isLiked: container.isLiked(item),
                    onLikeTapped: { container.toggleLike(for: item) }
                )
                .padding(.bottom, 100)
                .accessibilitySortPriority(basePriority)
            }
        }
    }
}

#Preview {
    ClothingCardView(item: PreviewItems.item, isSelected: true, basePriority: 10, onOpen: {})
        .environmentObject(PreviewContainer.containerViewModel)
}
