//
//  ShareButton.swift
//  joiefull
//
//  Created by Julien Cotte on 18/12/2025.
//

import SwiftUI

/// Circular button for sharing content
/// Uses the system share icon with a frosted glass background
struct ShareButton: View {
    /// Action to perform when tapped
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "square.and.arrow.up")
                .foregroundStyle(.primary)
                .padding(10)
                .background(.ultraThinMaterial)
                .clipShape(Circle())
        }
        // ACCESSIBILITY
        .accessibilityLabel(AccessibilityHandler.ShareButton.label)
        .accessibilityHint(AccessibilityHandler.ShareButton.hint)
    }
}

#Preview {
    ShareButton(action: {})
}
