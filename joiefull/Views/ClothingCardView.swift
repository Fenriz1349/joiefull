//
//  ClothingCardView.swift
//  joiefull
//
//  Created by Julien Cotte on 18/12/2025.
//

import SwiftUI

struct ClothingCardView: View {
    let item: Clothing

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {

            CardImageView(
                imageURL: item.picture.url,
                likes: item.likes
            )

            VStack(alignment: .leading) {

                HStack{
                    Text(item.name)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .lineLimit(1)
                    Spacer()
                    ScorePill()
                }

                HStack {
                    Text("\(Int(item.price))€")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    Spacer()
                    if item.originalPrice != item.price {
                        Text("\(Int(item.originalPrice))€")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .strikethrough()
                    }
                }
            }
        }
        .frame(width: CardImageView.side)
    }
}

#Preview {
    ClothingCardView(item: .preview)
}
