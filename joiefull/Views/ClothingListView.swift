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

    @EnvironmentObject private var catalog: ClothingCatalogViewModel
    @EnvironmentObject private var container: ClothingContainerViewModel

    var body: some View {
        GeometryReader { geo in
            if let state = catalog.state {
                EmptyListView(state: state,
                              searchReset: catalog.resetSearch,
                              catalogReset: { Task { await catalog.refreshInBackground() } })
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        ForEach(Category.allCases, id: \.self) { category in
                            let items = catalog.clothes(for: category)
                            let itemCount = LayoutRules.itemCount(for: geo.size, isSplitted: container.isSplitted)
                            ClothingCategoryRow(
                                category: category,
                                items: items,
                                itemCount: itemCount,
                                selectedItem: container.selectedItem,
                                onSelect: container.toggleSelection
                            )
                        }
                    }
                    .padding(.vertical)
                }
                .refreshable {
                    await catalog.refreshInBackground()
                }
            }
        }
        .searchable(text: $catalog.searchText, placement: .navigationBarDrawer(displayMode: .always))
    }
}

#Preview {
    ClothingListView()
        .environmentObject(PreviewContainer.catalogViewModel)
        .environmentObject(PreviewContainer.containerViewModel)
}

#Preview("Empty Catalog") {
    ClothingListView()
        .environmentObject(PreviewContainer.emptyCatalogViewModel())
        .environmentObject(PreviewContainer.containerViewModel)
}
