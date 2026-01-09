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
    var isSelected: Bool = false
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: isSelected ? "star.fill" : "star")
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(isSelected ? Color.orange.opacity(0.6) :Color.gray.opacity(0.6))
        }
    }
}

#Preview("not selected"){
    StarButton(action: {})
}

#Preview("selected") {
    StarButton(isSelected: true, action: {})
}
