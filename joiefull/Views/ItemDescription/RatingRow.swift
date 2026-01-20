//
//  RatingRow.swift
//  joiefull
//
//  Created by Julien Cotte on 18/12/2025.
//

import SwiftUI

/// Displays a row with user avatar and star rating buttons
/// Used for the review/rating interface
struct RatingRow: View {
    let rating: Int
    let starPressed: (Int) -> Void

    var body: some View {
        HStack(spacing: 10) {
            Image(.avatar)
                .resizable()
                .frame(width: 44, height: 44)
                .clipShape(Circle())
                // ACCESSIBILITY - Hide Avatar because it's purely visual
                .accessibilityHidden(true)

            HStack {
                ForEach(1..<6) { index in
                    StarButton(
                        index: index,
                        currentRating: rating,
                        isSelected: index <= rating,
                        action: { starPressed(index) }
                    )
                }
            }
            // ACCESSIBILITY
            .accessibilityElement(children: .contain)
            Spacer()
        }
    }
}

#Preview {
    RatingRow(rating: 0, starPressed: {_ in })
}
