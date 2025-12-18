//
//  CardImageView.swift
//  joiefull
//
//  Created by Julien Cotte on 18/12/2025.
//

import SwiftUI

struct CardImageView: View {
    static let side: CGFloat = 250

    let imageURL: String
    let likes: Int

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            AsyncImage(url: URL(string: imageURL)) { phase in
                switch phase {
                case .success(let image):
                    image.resizable().scaledToFill()
                default:
                    Color.gray.opacity(0.15)
                }
            }
            .frame(width: Self.side, height: Self.side)
            .clipped()
            .clipShape(RoundedRectangle(cornerRadius: 25))

            LikesPill(likes: likes)
                .padding(16)
        }
        .frame(width: Self.side, height: Self.side)
    }
}

#Preview {
    CardImageView(imageURL: Clothing.preview.picture.url,
                  likes: Clothing.preview.likes)
}
