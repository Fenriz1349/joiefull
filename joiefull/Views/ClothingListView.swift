//
//  ClothingListView.swift
//  joiefull
//
//  Created by Julien Cotte on 18/12/2025.
//

import SwiftUI

struct ClothingListView: View {
    @StateObject private var viewModel = ClothingLoadingViewModel()

    let selectedItem: Clothing?
    let onSelect: (Clothing) -> Void

    var body: some View {
        GeometryReader { geo in
            let itemCount = LayoutRules.itemCount(for: geo.size.width)

            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    ForEach(Category.allCases, id: \.self) { category in
                        ClothingCategoryRow(
                            category: category,
                            items: viewModel.clothes(for: category),
                            itemCount: itemCount,
                            selectedItem: selectedItem,
                            onSelect: onSelect
                        )
                    }
                }
                .padding(.vertical)
            }
        }
        .task {
            await viewModel.load()
        }
    }
}

#Preview {
    ClothingListView(selectedItem: Clothing.preview, onSelect: {_ in })
}
