//
//  ClothingDetailContentView.swift
//  joiefull
//
//  Created by Julien Cotte on 19/12/2025.
//

import SwiftUI

/// Displays the scrollable content section of a clothing detail view
/// Contains description, reviews, and user input areas
struct ClothingDetailContentView: View {
    @EnvironmentObject private var container: ClothingContainerViewModel

    let item: Clothing

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                DescriptionRow(isDetail: true, rating: container.getCalculatedRating(item), item: item)

                Text(item.descriptionText)
                .font(.subheadline)

                ReviewRow(rating: container.getRating(for: item),
                          starPressed: { index in
                    container.setNewRating(for: item, rating: index)
                })

                ReviewInputView()
            }
        }
    }
}

#Preview {
    ClothingDetailContentView(item: PreviewItems.item)
        .environmentObject(PreviewContainer.containerViewModel)
}
