//
//  RootView.swift
//  joiefull
//
//  Created by Julien Cotte on 19/12/2025.
//

import SwiftUI
import SwiftData
import Toasty

/// Root view of the application that manages adaptive layout
/// Displays a split view on large screens (iPad) or navigation stack on small screens (iPhone)
struct RootView: View {
    @EnvironmentObject var container: ClothingContainerViewModel
    @EnvironmentObject var loader: ClothingLoadingViewModel
    @EnvironmentObject var toastyManager: ToastyManager

    var body: some View {
        NavigationStack {
            Group {
                if loader.clothes.isEmpty {
                    LoadingScreen()
                        .task {
                            await loader.loadIfNeeded()
                        }
                } else {
                    GeometryReader { geo in
                        let allowsSplit = DeviceType.isSplitViewEnabled
                        let hasSelection = container.selectedItem != nil

                        HStack(spacing: 0) {
                            ClothingListView(
                                selectedItem: container.selectedItem,
                                onSelect: container.toggleSelection
                            )
                            .frame(
                                width: allowsSplit && hasSelection
                                ? geo.size.width * 2 / 3
                                : geo.size.width
                            )

                            if allowsSplit, let item = container.selectedItem {
                                ClothingDetailView(item: item, onClose: { container.selectedItem = nil })
                                    .frame(width: geo.size.width / 3)
                            }
                        }
                        .if(!allowsSplit) { view in
                            view.navigationDestination(
                                item: $container.selectedItem
                            ) { item in
                                ClothingDetailView(item: item, onClose: nil)
                            }
                        }
                    }
                }
            }
        }.onAppear {
            container.configure(toastyManager: toastyManager)
        }
    }
}

#Preview {
    RootView()
        .environmentObject(PreviewContainer.containerViewModel)
        .environmentObject(PreviewContainer.loadingViewModel)
}
