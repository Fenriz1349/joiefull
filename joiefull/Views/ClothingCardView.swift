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
            ProductImageContainer(item: item,
                                  aspectRatio: 3 / 4,
                                  displayedLikes: container.getdisplayedLikes(for: item),
                                  isLiked: container.isLiked(item),
                                  rating: container.getCalculatedRating(item),
                                  basePriority: basePriority,
                                  onOpen: onOpen,
                                  onLikeTapped: { container.toggleLike(for: item) })
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(isSelected ? Color.accentColor : .clear, lineWidth: 3)
            )
            DescriptionRow(rating: container.getCalculatedRating(item), item: item)
                .foregroundStyle(isSelected ? Color.accentColor : .primary)
                .accessibilityHidden(true)
        }
    }
}

#Preview {
    ClothingCardView(item: PreviewItems.item, isSelected: true, basePriority: 10, onOpen: {})
        .environmentObject(PreviewContainer.containerViewModel)
}
