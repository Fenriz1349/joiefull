//
//  ClothingCardView.swift
//  joiefull
//
//  Created by Julien Cotte on 18/12/2025.
//

import SwiftUI

struct ClothingCardView: View {
    @EnvironmentObject private var containerVM: ClothingContainerViewModel

    let item: Clothing
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
    ClothingCardView(item: .preview, isSelected: true)
}
