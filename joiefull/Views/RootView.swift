//
//  RootView.swift
//  joiefull
//
//  Created by Julien Cotte on 19/12/2025.
//

import SwiftUI
import Toasty

/// Root view of the application that manages adaptive layout
/// Displays a split view on iPad or navigation stack on iPhone
struct RootView: View {

    @EnvironmentObject var container: ClothingContainerViewModel
    @EnvironmentObject var catalog: ClothingCatalogViewModel
    @EnvironmentObject var toastyManager: ToastyManager

    @FocusState private var isReviewFocused: Bool

    var allowsSplit: Bool { DeviceType.isSplitViewEnabled }
    var hasSelection: Bool {container.selectedItem != nil }

    var body: some View {
        NavigationStack {
            Group {
                if catalog.isLoading {
                    LoadingScreen()
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
                            ClothingListView()
                                .frame(width: listSize.width, height: listSize.height)

                            if allowsSplit, let item = container.selectedItem {
                                ClothingDetailView(externalFocus: $isReviewFocused,
                                                   item: item,
                                                   onClose: { container.selectedItem = nil })
                                    .frame(width: detailSize.width, height: detailSize.height)
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture { isReviewFocused = false }
                        .if(!allowsSplit) { view in
                            view.navigationDestination(
                                item: $container.selectedItem
                            ) { item in
                                ClothingDetailView(externalFocus: $isReviewFocused, item: item, onClose: nil)
                            }
                        }
                    }
                }
            }
        }
        .task { await catalog.loadIfNeeded() }
        .onAppear {
            container.configure(toastyManager: toastyManager)
        }
    }
}

#Preview {
    RootView()
        .environmentObject(PreviewContainer.containerViewModel)
        .environmentObject(PreviewContainer.catalogViewModel)
        .environmentObject(PreviewContainer.sampleToastyManager)
}

#Preview("320x568 forced") {
    RootView()
        .environmentObject(PreviewContainer.containerViewModel)
        .environmentObject(PreviewContainer.catalogViewModel)
        .environmentObject(PreviewContainer.sampleToastyManager)
        .frame(width: 320, height: 568)
        .clipped()
}

#Preview("iPad mini (portrait)") {
    RootView()
        .environmentObject(PreviewContainer.containerViewModel)
        .environmentObject(PreviewContainer.catalogViewModel)
        .environmentObject(PreviewContainer.sampleToastyManager)
        .frame(width: 744, height: 1133)
        .clipped()
}

#Preview("iPad mini (landscape)") {
    RootView()
        .environmentObject(PreviewContainer.containerViewModel)
        .environmentObject(PreviewContainer.catalogViewModel)
        .environmentObject(PreviewContainer.sampleToastyManager)
        .frame(width: 1133, height: 744)
        .clipped()
}
