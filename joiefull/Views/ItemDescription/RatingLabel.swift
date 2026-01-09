//
//  RatingLabel.swift
//  joiefull
//
//  Created by Julien Cotte on 18/12/2025.
//

import SwiftUI

/// Displays a rating value with a filled star icon
/// Used to show the average rating of a clothing item
struct RatingLabel: View {
    /// The rating value to display (0.0 to 5.0)
    let rating: Double

    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: "star.fill")
                .foregroundStyle(.orange)
            Text(String(format: "%0.1f", rating))
                .fontWeight(.semibold)
        }
    }
}

#Preview {
    RatingLabel(rating: PreviewItems.item.globalRating)
}
