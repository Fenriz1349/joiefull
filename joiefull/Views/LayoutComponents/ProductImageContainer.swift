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
    var aspectRatio: CGFloat = 1

    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            let height = width / aspectRatio

            VStack {
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
                .accessibilityHidden(true)
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
        aspectRatio: 3/4
    )
    .padding()
}

#Preview("Detail – iPhone") {
    ProductImageContainer(
        imageURL: PreviewItems.item.picture.url
    )
    .padding()
}

#Preview("Detail – iPhone paysage (carré)") {
    ProductImageContainer(
        imageURL: PreviewItems.item.picture.url
    )
    .frame(width: 350) // simulated landscape Iphone width
    .padding()
}

#Preview("Detail – iPad split / paysage (rectangulaire)") {
    ProductImageContainer(
        imageURL: PreviewItems.item.picture.url
    )
    .frame(width: 500) // simulated portrait Ipad width
    .padding()
}
