//
//  DescriptionRow.swift
//  joiefull
//
//  Created by Julien Cotte on 18/12/2025.
//

import SwiftUI

/// Displays clothing item name, rating, and pricing information
/// Adapts typography and layout based on whether it's shown in detail or card view
struct DescriptionRow: View {
    var isDetail: Bool = false
    let rating: Double
    let item: Clothing

    private var titleFont: Font { isDetail ? .title3 : .subheadline }

    private var priceFont: Font { isDetail ? .headline : .subheadline }

    var body: some View {
        VStack(alignment: .leading, spacing: isDetail ? 12 : 8) {

            HStack {
                Text(item.name)
                    .font(titleFont)
                    .fontWeight(.bold)
                    .lineLimit(isDetail ? nil : 1)

                Spacer()

                RatingLabel(rating: rating)
            }

            HStack {
                Text("\(Int(item.price))€")
                    .font(priceFont)

                Spacer()

                if item.originalPrice != item.price {
                    Text("\(Int(item.originalPrice))€")
                        .font(priceFont)
                        .foregroundStyle(.secondary)
                        .strikethrough()
                }
            }
        }
    }
}

#Preview {
    DescriptionRow(rating: PreviewItems.item.globalRating, item: PreviewItems.item)
}
