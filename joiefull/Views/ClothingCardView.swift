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
    @EnvironmentObject private var containerVM: ClothingContainerViewModel

    /// The clothing item to display
    let item: Clothing

    /// Whether this card is currently selected (used for highlighting)
    let isSelected: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {

            ProductImageContainer(
                imageURL: item.picture.url,
                likes: item.likes + (containerVM.isLiked(item) ? 1 : 0),
                isLiked: containerVM.isLiked(item),
                onLikeTapped: { containerVM.toggleLike(for: item) }
            )
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(
                        isSelected ? Color.accentColor : .clear,
                        lineWidth: 3
                    )
            )

            DescriptionRow(item: item)
                .foregroundStyle(isSelected ? Color.accentColor : .primary)
        }
    }
}

#Preview {
    ClothingCardView(item: PreviewItems.item, isSelected: true)
        .environmentObject(PreviewContainer.containerViewModel)
}
