//
//  DetailImageOverlay.swift
//  joiefull
//
//  Created by Julien Cotte on 18/12/2025.
//

import SwiftUI

struct DetailImageOverlay: View {
    let likes: Int
    let onShare: () -> Void

    var body: some View {
        VStack {
            HStack {
                Spacer()
                ShareButton(action: onShare)
            }

            Spacer()

            HStack {
                Spacer()
                LikesPill(likes: likes)
            }
        }
        .padding(12)
    }
}

#Preview {
    DetailImageOverlay(likes: Clothing.preview.likes, onShare: {})
}
