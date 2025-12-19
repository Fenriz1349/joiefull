//
//  RootView.swift
//  joiefull
//
//  Created by Julien Cotte on 19/12/2025.
//

import SwiftUI
import SwiftData

struct RootView: View {
    @EnvironmentObject var containerVM: ClothingContainerViewModel

    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                let allowsSplit = LayoutRules.allowsSplit(geo.size)
                let hasSelection = containerVM.selectedItem != nil

                HStack(spacing: 0) {

                    ClothingListView(
                        selectedItem: containerVM.selectedItem,
                        onSelect: containerVM.toggleSelection
                    )
                    .frame(
                        width: allowsSplit && hasSelection
                            ? geo.size.width * 2 / 3
                            : geo.size.width
                    )

                    if allowsSplit, let item = containerVM.selectedItem {
                        ClothingDetailView(item: item)
                            .frame(width: geo.size.width / 3)
                    }
                }
                .if(!allowsSplit) { view in
                    view.navigationDestination(
                        item: $containerVM.selectedItem
                    ) { item in
                        ClothingDetailView(item: item)
                    }
                }
            }
        }
    }
}

#Preview {
    RootView()
}
