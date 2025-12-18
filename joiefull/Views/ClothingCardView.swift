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

            ImageView(
                imageURL: item.picture.url,
                likes: item.likes
            )

            DescriptionRow(item: item)
        }
    }
}

#Preview {
    ClothingCardView(item: .preview)
}
