//
//  CloseButton.swift
//  joiefull
//
//  Created by Julien Cotte on 22/01/2026.
//

import SwiftUI

/// Circular button for sharing content
/// Uses the system share icon with a frosted glass background
struct CloseButton: View {
    /// Action to perform when tapped
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "xmark")
                .foregroundStyle(.red)
                .padding(10)
                .background(.ultraThinMaterial)
                .clipShape(Circle())
        }
        // ACCESSIBILITY
        .accessibilityLabel(AccessibilityHandler.CloseButton.label)
        .accessibilityHint(AccessibilityHandler.CloseButton.hint)
    }
}

#Preview {
    CloseButton(action: {})
}
