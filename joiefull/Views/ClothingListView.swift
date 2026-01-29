//
//  ClothingListView.swift
//  joiefull
//
//  Created by Julien Cotte on 18/12/2025.
//

import SwiftUI

/// Main list view displaying clothing items organized by category.
/// Adapts the number of columns based on available screen width.
struct ClothingListView: View {

    @EnvironmentObject private var loader: ClothingLoadingViewModel
    @EnvironmentObject private var container: ClothingContainerViewModel

    /// Currently selected clothing item (for highlighting in split view).
    let selectedItem: Clothing?

    /// Callback when a clothing item is selected.
    let onSelect: (Clothing) -> Void

    var body: some View {
        GeometryReader { geo in
            let itemCount = LayoutRules.itemCount(for: geo.size, isSplitted: container.isSplitted)

            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    ForEach(Category.allCases, id: \.self) { category in
                        ClothingCategoryRow(
                            category: category,
                            items: loader.clothes(for: category),
                            itemCount: itemCount,
                            selectedItem: selectedItem,
                            onSelect: onSelect
                        )
                    }
                }
                .padding(.vertical)
            }
        }
    }
}

#Preview {
    ClothingListView(selectedItem: PreviewItems.item, onSelect: { _ in })
        .environmentObject(PreviewContainer.loadingViewModel)
        .environmentObject(PreviewContainer.containerViewModel)
}
