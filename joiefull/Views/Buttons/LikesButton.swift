//
//  LikesButton.swift
//  joiefull
//
//  Created by Julien Cotte on 18/12/2025.
//

import SwiftUI

struct LikesButton: View {
    let likes: Int
    let isLiked: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                Image(systemName: isLiked ? "heart.fill" : "heart")
                Text("\(likes)")
                    .font(.caption.weight(.semibold))
            }
            .foregroundStyle(isLiked ? .white : .black)
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(
                Capsule().fill(isLiked ? .red : .white)
            )
        }
        .buttonStyle(.plain)
    }
}

#Preview("Not liked") {
    LikesButton(
        likes: 42,
        isLiked: false,
        action: {}
    )
    .padding()
    .background(Color.gray.opacity(0.2))
}

#Preview("Liked") {
    LikesButton(
        likes: 43,
        isLiked: true,
        action: {}
    )
    .padding()
    .background(Color.gray.opacity(0.2))
}
