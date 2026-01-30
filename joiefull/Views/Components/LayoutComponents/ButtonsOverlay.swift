//
//  ButtonsOverlay.swift
//  joiefull
//
//  Created by Julien Cotte on 19/01/2026.
//

import SwiftUI

/// Button overlays (like button + optional share button + optional close button)
struct ButtonsOverlay: View {

    let likes: Int
    let isLiked: Bool
    let onLikeTapped: () -> Void
    var onShareTapped: (() -> Void)?
    var onClose: (() -> Void)?

    var body: some View {
        VStack(alignment: .trailing) {
            HStack {
                if let onClose {
                    CloseButton(action: onClose)
                        .padding(16)
                }

                Spacer()
                if let onShareTapped {
                    ShareButton(action: { onShareTapped() })
                        .padding(16)
                }
            }
            Spacer()
            LikeButton(likes: likes, isLiked: isLiked, action: onLikeTapped)
                .padding(16)
        }
    }
}

#Preview {
    ButtonsOverlay(likes: 24,
                   isLiked: true,
                   onLikeTapped: {},
                   onShareTapped: {},
                   onClose: {}
    )
}
