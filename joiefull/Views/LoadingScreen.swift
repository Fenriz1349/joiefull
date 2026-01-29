//
//  LoadingScreen.swift
//  joiefull
//
//  Created by Julien Cotte on 23/01/2026.
//

import SwiftUI

struct LoadingScreen: View {

    @EnvironmentObject var loader: ClothingLoadingViewModel

    var body: some View {
        BrandingContentView {
            if let error = loader.loadingError {
                VStack(spacing: 24) {
                    Text(error.errorDescription)
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .accessibilityLabel(AccessibilityHandler.LoadingError.label)
                        .accessibilityHint(AccessibilityHandler.LoadingError.hint)
                    ReloadButton(action: {Task { await loader.resetAndReload() }})
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
        .environmentObject(PreviewContainer.loadingViewModel)
}

#Preview("Loading - HTTP Error") {
    LoadingScreen()
        .environmentObject(PreviewContainer.loadingViewModelWithError(ClothingServiceError.network))
}
