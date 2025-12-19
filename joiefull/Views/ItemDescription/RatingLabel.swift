//
//  RatingLabel.swift
//  joiefull
//
//  Created by Julien Cotte on 18/12/2025.
//

import SwiftUI

struct RatingLabel: View {
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
    RatingLabel(rating: Clothing.preview.globalRating)
}
