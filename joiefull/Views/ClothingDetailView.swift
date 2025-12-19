//
//  ClothingDetailView.swift
//  joiefull
//
//  Created by Julien Cotte on 18/12/2025.
//

import SwiftUI

struct ClothingDetailView: View {
    let item: Clothing

    @Environment(\.horizontalSizeClass) private var hSizeClass

    var body: some View {
        GeometryReader { geo in
            let isPhoneLandscape =
            hSizeClass == .compact && geo.size.width > geo.size.height
            
            let imageRatio: CGFloat = isPhoneLandscape ? 1 : 3/4
            
            let layout = isPhoneLandscape
            ? AnyLayout(HStackLayout(alignment: .top, spacing: 20))
            : AnyLayout(VStackLayout(alignment: .leading, spacing: 20))
            ScrollView {
                layout {
                    ProductImageContainer(imageURL: item.picture.url,
                                          likes: item.likes,
                                          aspectRatio: imageRatio,
                                          showsShareButton: true)
//                    .frame(maxWidth: .infinity)
                    
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
                .padding()
            }
        }
    }
}

#Preview {
    ClothingDetailView(item: .preview)
}
