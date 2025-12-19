//
//  ClothingDetailContentView.swift
//  joiefull
//
//  Created by Julien Cotte on 19/12/2025.
//

import SwiftUI

struct ClothingDetailContentView: View {
    let item: Clothing

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                DescriptionRow(isDetail: true, item: item)

                Text("""
                Pull vert forêt à motif torsadé élégant, tricot finement travaillé avec manches bouffantes et col montant;
                doux et chaleureux.
                """)
                .font(.subheadline)

                ReviewRow()
                ReviewInputView()
            }
        }
    }
}

#Preview {
    ClothingDetailContentView(item: Clothing.preview)
}
