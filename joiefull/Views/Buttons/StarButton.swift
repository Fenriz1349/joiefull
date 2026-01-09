//
//  StarButton.swift
//  joiefull
//
//  Created by Julien Cotte on 18/12/2025.
//

import SwiftUI

/// Displays an unselected star icon for rating interfaces
/// Used as part of the review/rating system
struct StarButton: View {
    var body: some View {
        Image(systemName: "star")
            .font(.system(size: 28, weight: .semibold))
            .foregroundStyle(Color.gray.opacity(0.6))
    }
}

#Preview {
    StarButton()
}
