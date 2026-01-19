//
//  ButtonsOverlay.swift
//  joiefull
//
//  Created by Julien Cotte on 19/01/2026.
//

import SwiftUI

struct ButtonsOverlay: View {
    let likes: Int
    let isLiked: Bool
    let onLikeTapped: () -> Void
    var onShareTapped: (() -> Void)? = nil

    var body: some View {
        VStack(alignment: .trailing) {
            if onShareTapped != nil {
                ShareButton(action: { onShareTapped?() })
                    .padding(16)
                Spacer()
            }

            LikeButton(likes: likes, isLiked: isLiked, action: onLikeTapped)
                .padding(16)
        }
    }
}

#Preview {
    ButtonsOverlay(likes: 24,
                   isLiked: true,
                   onLikeTapped: {},
                   onShareTapped: {}
    )
}
