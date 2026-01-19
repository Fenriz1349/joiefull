//
//  LikesButton.swift
//  joiefull
//
//  Created by Julien Cotte on 18/12/2025.
//

import SwiftUI

/// Interactive button displaying like count with heart icon
/// Changes appearance based on liked state
struct LikeButton: View {
    let likes: Int
    let isLiked: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                Image(systemName: isLiked ? "heart.fill" : "heart")
                Text("\(likes + (isLiked ? 1 : 0))")
                    .font(.caption.weight(.semibold))
            }
            .foregroundStyle(isLiked ? .white : .black)
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(Capsule().fill(isLiked ? .red : .white))
        }
        .buttonStyle(.plain)
        // ACCESSIBILITY
        .accessibilityLabel(AccessibilityHandler.LikeButton.label(isLiked: isLiked))
        .accessibilityHint(AccessibilityHandler.LikeButton.hint(isLiked: isLiked))
        .accessibilityValue(AccessibilityHandler.LikeButton.value(likes: likes))
    }
}

#Preview("Not liked") {
    LikeButton(
        likes: 42,
        isLiked: false,
        action: {}
    )
    .padding()
    .background(Color.gray.opacity(0.2))
}

#Preview("Liked") {
    LikeButton(
        likes: 43,
        isLiked: true,
        action: {}
    )
    .padding()
    .background(Color.gray.opacity(0.2))
}
