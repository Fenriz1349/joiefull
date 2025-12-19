//
//  RootView.swift
//  joiefull
//
//  Created by Julien Cotte on 19/12/2025.
//

import SwiftUI

struct RootView: View {
    @Environment(\.horizontalSizeClass) private var sizeClass
    @State private var selectedItem: Clothing?

    var body: some View {
        if sizeClass == .compact {
            NavigationStack {
                ClothingListView { item in
                    selectedItem = item
                }
                .navigationDestination(item: $selectedItem) { item in
                    ClothingDetailView(item: item)
                }
            }
        } else {
            NavigationSplitView {
                ClothingListView { item in
                    selectedItem = item
                }
            } detail: {
                if let selectedItem {
                    ClothingDetailView(item: selectedItem)
                } else {
                    Text("Sélectionnez un article")
                        .foregroundStyle(.secondary)
                }
            }
        }
    }
}

#Preview {
    RootView()
}
