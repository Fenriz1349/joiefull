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
    let onOpen: () -> Void

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(alignment: .leading, spacing: 8) {
                ProductImageContainer(imageURL: item.picture.url, aspectRatio: 3 / 4)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(isSelected ? Color.accentColor : .clear, lineWidth: 3)
                    )
                DescriptionRow(rating: container.getCalculatedRating(item), item: item)
                    .foregroundStyle(isSelected ? Color.accentColor : .primary)
            }
            .accessibilityElement(children: .ignore)
            .accessibilityAddTraits(.isButton)
            .accessibilityLabel(
                AccessibilityHandler.ClothingCard.fullLabel(
                    itemName: item.name,
                    imageDescription: item.picture.description,
                    price: item.price,
                    originalPrice: item.originalPrice,
                    rating: container.getCalculatedRating(item),
                    category: item.category.title
                )
            )
            .accessibilityHint(AccessibilityHandler.ClothingCard.hint)
            ButtonsOverlay(
                likes: item.likes,
                isLiked: container.isLiked(item),
                onLikeTapped: { container.toggleLike(for: item) }
            )
            .padding(.bottom, 50)
        }
    }
}

#Preview {
    ClothingCardView(item: PreviewItems.item, isSelected: true, onOpen: {})
        .environmentObject(PreviewContainer.containerViewModel)
}
