//
//  StarButton.swift
//  joiefull
//
//  Created by Julien Cotte on 18/12/2025.
//

import SwiftUI

/// Displays an selected or unselected star icon for rating interfaces
/// Used as part of the review/rating system
struct StarButton: View {

    let index: Int
    let currentRating: Int
    var isSelected: Bool = false
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: isSelected ? "star.fill" : "star")
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(isSelected ? Color.orange.opacity(0.6) : Color.gray.opacity(0.6))
        }
        .buttonStyle(.plain)
        // ACCESSIBILITY
        .accessibilityLabel(AccessibilityHandler.StarButton.label(index: index))
        .accessibilityHint(AccessibilityHandler.StarButton.hint(index: index))
        .accessibilityValue(AccessibilityHandler.StarButton.value(isSelected: isSelected))
        .accessibilityAddTraits(.isButton)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}

#Preview("not selected"){
    StarButton(index: 1, currentRating: 3, action: {})
}

#Preview("selected") {
    StarButton(index: 1, currentRating: 3, isSelected: true, action: {})
}
