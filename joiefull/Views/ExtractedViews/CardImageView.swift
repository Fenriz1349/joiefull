//
//  CardImageView.swift
//  joiefull
//
//  Created by Julien Cotte on 18/12/2025.
//

import SwiftUI

struct CardImageView: View {
    let imageURL: String
    let likes: Int

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottomTrailing) {

                AsyncImage(url: URL(string: imageURL)) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width, height: geometry.size.width)

                    case .failure(_):
                        Image("AppIconPreview")
                            .resizable()
                            .scaledToFit()
                            .padding(24)
                            .frame(width: geometry.size.width, height: geometry.size.width)

                    case .empty:
                        Color.gray.opacity(0.15)
                            .frame(width: geometry.size.width, height: geometry.size.width)

                    @unknown default:
                        Color.gray.opacity(0.15)
                            .frame(width: geometry.size.width, height: geometry.size.width)
                    }
                }
                .clipped()

                LikesPill(likes: likes)
                    .padding(16)
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .clipShape(RoundedRectangle(cornerRadius: 25))
    }
}

#Preview {
    CardImageView(imageURL: Clothing.preview.picture.url,
                  likes: Clothing.preview.likes)
}
