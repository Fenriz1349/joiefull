//
//  RootView.swift
//  joiefull
//
//  Created by Julien Cotte on 19/12/2025.
//

import SwiftUI

struct RootView: View {
    @StateObject private var containerVM = ClothingContainerViewModel()

    var body: some View {
        GeometryReader { geo in
            let hasSelection = containerVM.selectedItem != nil

            HStack(spacing: 0) {
                ClothingListView(
                    selectedItem: containerVM.selectedItem,
                    onSelect: containerVM.toggleSelection
                )
                .frame(
                    width: hasSelection
                        ? geo.size.width * 2 / 3
                        : geo.size.width
                )

                if let item = containerVM.selectedItem {
                    ClothingDetailView(item: item)
                        .frame(width: geo.size.width / 3)
                }
            }
        }
    }
}

#Preview {
    RootView()
}
