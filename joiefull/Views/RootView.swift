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

    var allowsSplit: Bool { DeviceType.isSplitViewEnabled }
    var hasSelection: Bool {container.selectedItem != nil }

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
                        let layout = LayoutRules.splitLayout(for: geo.size)
                        let listSize = LayoutRules.listFrame(in: geo.size,
                                                             allowsSplit: allowsSplit,
                                                             hasSelection: hasSelection)
                        let detailSize = LayoutRules.detailFrame(in: geo.size,
                                                                 allowsSplit: allowsSplit,
                                                                 hasSelection: hasSelection)
                        layout {
                            ClothingListView(
                                selectedItem: container.selectedItem,
                                onSelect: container.toggleSelection
                            )
                            .frame(width: listSize.width, height: listSize.height)

                            if allowsSplit, let item = container.selectedItem {
                                ClothingDetailView(item: item, onClose: { container.selectedItem = nil })
                                    .frame(width: detailSize.width, height: detailSize.height)
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
        .environmentObject(PreviewContainer.sampleToastyManager)
}

#Preview("320x568 forced") {
    RootView()
        .environmentObject(PreviewContainer.containerViewModel)
        .environmentObject(PreviewContainer.loadingViewModel)
        .environmentObject(PreviewContainer.sampleToastyManager)
        .frame(width: 320, height: 568)
        .clipped()
}

#Preview("iPad mini (portrait)") {
    RootView()
        .environmentObject(PreviewContainer.containerViewModel)
        .environmentObject(PreviewContainer.loadingViewModel)
        .environmentObject(PreviewContainer.sampleToastyManager)
        .frame(width: 744, height: 1133)
        .clipped()
}

#Preview("iPad mini (landscape)") {
    RootView()
        .environmentObject(PreviewContainer.containerViewModel)
        .environmentObject(PreviewContainer.loadingViewModel)
        .environmentObject(PreviewContainer.sampleToastyManager)
        .frame(width: 1133, height: 744)
        .clipped()
}
