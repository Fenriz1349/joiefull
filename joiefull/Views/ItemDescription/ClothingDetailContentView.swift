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
    let item: Clothing

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                DescriptionRow(isDetail: true, item: item)

                Text(item.descriptionText)
                .font(.subheadline)

                ReviewRow()
                ReviewInputView()
            }
        }
    }
}

#Preview {
    ClothingDetailContentView(item: PreviewItems.item)
}
