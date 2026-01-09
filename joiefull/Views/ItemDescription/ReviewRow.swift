//
//  ReviewRow.swift
//  joiefull
//
//  Created by Julien Cotte on 18/12/2025.
//

import SwiftUI

/// Displays a row with user avatar and star rating buttons
/// Used for the review/rating interface
struct ReviewRow: View {
    let rating: Int
    let starPressed: (Int) -> Void

    var body: some View {
        HStack(spacing: 10) {
            Image(.avatar)
                .resizable()
                .frame(width: 44, height: 44)
                .clipShape(Circle())

                HStack {
                    ForEach(1..<6) { index in
                        StarButton(isSelected: index <= rating,
                                   action: { starPressed(index) })
                    }
                }
            Spacer()
        }
    }
}

#Preview {
    ReviewRow(rating: 0, starPressed: {_ in })
}
