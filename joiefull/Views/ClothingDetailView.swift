//
//  ClothingDetailView.swift
//  joiefull
//
//  Created by Julien Cotte on 18/12/2025.
//

import SwiftUI

struct ClothingDetailView: View {
    let item: Clothing

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                ImageView(imageURL: item.picture.url,
                          likes: item.likes,
                          isDetailScreen: true,
                          aspectRatio: 0.9)

                DescriptionRow(isDetail: true, item: item)

                Text("""
                Pull vert forêt à motif torsadé élégant, tricot finement travaillé avec manches bouffantes et col montant;
                doux et chaleureux.
                """)
                .font(.subheadline)

                ReviewRow()

                ReviewInputView()
            }
            .padding()
        }
    }
}

#Preview {
    ClothingDetailView(item: .preview)
}
