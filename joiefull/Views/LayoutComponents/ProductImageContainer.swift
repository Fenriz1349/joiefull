//
//  ProductImageContainer.swift
//  joiefull
//
//  Created by Julien Cotte on 19/12/2025.
//

import SwiftUI

/// Image container with overlays (like button + optional share button)
/// Enforces a given aspect ratio based on available width using GeometryReader
struct ProductImageContainer: View {
    let imageURL: String
    let likes: Int
    let isLiked: Bool
    let onLikeTapped: () -> Void
    var onShareTapped: (() -> Void)? = nil

    var aspectRatio: CGFloat = 1

    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            let height = width / aspectRatio

            ZStack(alignment: .bottomTrailing) {

                AsyncImage(url: URL(string: imageURL)) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()

                    default:
                        Image("AppIconPreview")
                            .resizable()
                            .scaledToFit()
                            .padding(24)
                    }
                }
                .frame(width: width, height: height)
                .clipped()

                VStack(alignment: .trailing) {
                    if (onShareTapped != nil) {
                        ShareButton(action: { onShareTapped?() })
                            .padding(16)
                        Spacer()
                    }

                    LikeButton(likes: likes, isLiked: isLiked, action: onLikeTapped)
                    .padding(16)
                }
            }
            .frame(width: width, height: height)
            .clipShape(RoundedRectangle(cornerRadius: 25))
        }
        .aspectRatio(aspectRatio, contentMode: .fit)
    }
}

#Preview("Card – portrait (rectangulaire)") {
    ProductImageContainer(
        imageURL: PreviewItems.item.picture.url,
        likes: 24,
        isLiked: true,
        onLikeTapped: {},
        aspectRatio: 3/4
    )
    .padding()
}

#Preview("Detail – iPhone") {
    ProductImageContainer(
        imageURL: PreviewItems.item.picture.url,
        likes: 24,
        isLiked: true,
        onLikeTapped: {},
        onShareTapped: {}
    )
    .padding()
}

#Preview("Detail – iPhone paysage (carré)") {
    ProductImageContainer(
        imageURL: PreviewItems.item.picture.url,
        likes: 24,
        isLiked: true,
        onLikeTapped: {},
        onShareTapped: {}
    )
    .frame(width: 350) // simulated landscape Iphone width
    .padding()
}

#Preview("Detail – iPad split / paysage (rectangulaire)") {
    ProductImageContainer(
        imageURL: PreviewItems.item.picture.url,
        likes: 24,
        isLiked: true,
        onLikeTapped: {},
        onShareTapped: {}
    )
    .frame(width: 500) // simulated portrait Ipad width
    .padding()
}
