//
//  ImageView.swift
//  joiefull
//
//  Created by Julien Cotte on 18/12/2025.
//

import SwiftUI

struct ImageView: View {
    let imageURL: String
    let likes: Int
    var isDetailScreen: Bool = false

    var aspectRatio: CGFloat { isDetailScreen ? 0.9 : 1 }

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottomTrailing) {

                AsyncImage(url: URL(string: imageURL)) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width, height: geometry.size.width / aspectRatio)

                    default:
                        Image("AppIconPreview")
                            .resizable()
                            .scaledToFit()
                            .padding(24)
                            .frame(width: geometry.size.width, height: geometry.size.width / aspectRatio)
                    }
                }
                .clipped()

                VStack(alignment: .trailing) {
                    if isDetailScreen {
                        ShareButton(action: {})
                            .padding(16)
                        Spacer()
                    }
                    LikesPill(likes: likes)
                        .padding(16)
                }
            }
        }
        .aspectRatio(aspectRatio, contentMode: .fit)
        .clipShape(RoundedRectangle(cornerRadius: 25))
    }
}

#Preview("Card – carré") {
    ImageView(imageURL: Clothing.preview.picture.url,
              likes: Clothing.preview.likes)
    .padding()
}

#Preview("Detail – vertical") {
    ImageView(imageURL: Clothing.preview.picture.url,
              likes: Clothing.preview.likes,
              isDetailScreen: true)
    .padding()
}
