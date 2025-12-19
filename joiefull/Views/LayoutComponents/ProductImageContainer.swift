//
//  ProductImageContainer.swift
//  joiefull
//
//  Created by Julien Cotte on 19/12/2025.
//

import SwiftUI

struct ProductImageContainer: View {
    let imageURL: String
    let likes: Int
    var aspectRatio: CGFloat = 1
    var showsShareButton: Bool = false

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
                    if showsShareButton {
                        ShareButton(action: {})
                            .padding(16)
                        Spacer()
                    }
                    LikesButton(likes: likes)
                        .padding(16)
                }
            }
            .frame(width: width, height: height)
            .clipShape(RoundedRectangle(cornerRadius: 25))
        }
        .aspectRatio(aspectRatio, contentMode: .fit)
    }
}


#Preview("Card – carré") {
    ProductImageContainer(
        imageURL: Clothing.preview.picture.url,
        likes: 24
    )
    .padding()
}

#Preview("Detail – iPhone portrait (rectangulaire)") {
    ProductImageContainer(
        imageURL: Clothing.preview.picture.url,
        likes: 24,
        aspectRatio: 3/4,
        showsShareButton: true
    )
    .padding()
}

#Preview("Detail – iPhone paysage (carré)") {
    ProductImageContainer(
        imageURL: Clothing.preview.picture.url,
        likes: 24,
        aspectRatio: 1,
        showsShareButton: true
    )
    .frame(width: 350) // largeur simulée iPhone paysage
    .padding()
}

#Preview("Detail – iPad split / paysage (rectangulaire)") {
    ProductImageContainer(
        imageURL: Clothing.preview.picture.url,
        likes: 24,
        aspectRatio: 3/4,
        showsShareButton: true
    )
    .frame(width: 500) // largeur simulée colonne iPad
    .padding()
}

