//
//  ClothingListView.swift
//  joiefull
//
//  Created by Julien Cotte on 18/12/2025.
//

import SwiftUI

/// Main list view displaying clothing items organized by category
/// Adapts the number of columns based on available screen width
struct ClothingListView: View {
    @StateObject private var viewModel = ClothingLoadingViewModel()

    /// Currently selected clothing item (for highlighting in split view)
    let selectedItem: Clothing?

    /// Callback when a clothing item is selected
    let onSelect: (Clothing) -> Void

    var body: some View {
        GeometryReader { geo in
            // Calculate optimal number of items per row based on width
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
    ClothingListView(selectedItem: PreviewItems.item, onSelect: {_ in })
        .environmentObject(PreviewContainer.containerViewModel)
}
