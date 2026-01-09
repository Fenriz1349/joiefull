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
    var body: some View {
        HStack(spacing: 10) {
            Image(.avatar)
                .resizable()
                .frame(width: 44, height: 44)
                .clipShape(Circle())

            HStack {
                ForEach(0..<5) { _ in
                    StarButton()
                }
            }
            Spacer()
        }
    }
}

#Preview {
    ReviewRow()
}
