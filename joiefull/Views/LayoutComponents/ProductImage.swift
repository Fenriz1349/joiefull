//
//  ProductImage.swift
//  joiefull
//
//  Created by Julien Cotte on 18/12/2025.
//

import SwiftUI

/// Lightweight image view used inside product containers
/// Loads an image from URL and falls back to a local placeholder
struct ProductImage: View {

    let imageURL: String

    var body: some View {
        AsyncImage(url: URL(string: imageURL)) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
            default:
                Image(.launchLogo)
                    .resizable()
                    .scaledToFit()
                    .padding(24)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .clipped()
    }
}

#Preview {
    ProductImage(imageURL: PreviewItems.item.picture.url)
}
