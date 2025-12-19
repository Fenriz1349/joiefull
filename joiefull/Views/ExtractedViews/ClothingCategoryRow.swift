//
//  ClothingCategoryRow.swift
//  joiefull
//
//  Created by Julien Cotte on 19/12/2025.
//

import SwiftUI

struct ClothingCategoryRow: View {
    let category: Category
    let items: [Clothing]
    let itemCount: Int
    let selectedItem: Clothing?
    let onSelect: (Clothing) -> Void

    var body: some View {
        VStack(alignment: .leading) {

            Text(category.title)
                .font(.title2)
                .bold()
                .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 16) {
                    ForEach(items) { item in
                        Button {
                            onSelect(item)
                        } label: {
                            ClothingCardView(
                                item: item,
                                isSelected: selectedItem?.id == item.id
                            )
                            .containerRelativeFrame(
                                .horizontal,
                                count: itemCount,
                                spacing: 16
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
                .scrollTargetLayout()
            }
            .contentMargins(.horizontal, 16, for: .scrollContent)
            .scrollTargetBehavior(.viewAligned)
        }
    }
}

#Preview {
//    ClothingCategoryRow()
}
