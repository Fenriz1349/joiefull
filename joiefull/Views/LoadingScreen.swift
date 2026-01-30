//
//  LoadingScreen.swift
//  joiefull
//
//  Created by Julien Cotte on 23/01/2026.
//

import SwiftUI

/// View to diplay when loading
/// Can diplays a ProgressView or an Error message
struct LoadingScreen: View {

    @EnvironmentObject var catalog: ClothingCatalogViewModel

    var body: some View {
        BrandingContentView {
            if let error = catalog.loadingError {
                VStack(spacing: 24) {
                    Text(error.errorDescription)
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .accessibilityLabel(AccessibilityHandler.LoadingError.label)
                        .accessibilityHint(AccessibilityHandler.LoadingError.hint)
                    ReloadButton(action: {Task { await catalog.resetAndReload() }})
                }
                .padding(.horizontal, 24)
            } else {
                ProgressView("Chargement…")
                    .accessibilityLabel(AccessibilityHandler.Loading.label)
                    .accessibilityHint(AccessibilityHandler.Loading.hint)
            }
        }
    }
}

#Preview("Loading - In Progress") {
    LoadingScreen()
        .environmentObject(PreviewContainer.catalogViewModel)
}

#Preview("Loading - HTTP Error") {
    LoadingScreen()
        .environmentObject(PreviewContainer.catalogViewModelWithError(ClothingServiceError.network))
}
