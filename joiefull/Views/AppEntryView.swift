//
//  AppEntryView.swift
//  joiefull
//
//  Created by Julien Cotte on 30/01/2026.
//

import SwiftUI

/// Entry point view that manages the app launch sequence
/// Displays LaunchScreen briefly, then transitions to RootView with animation
struct AppEntryView: View {

    @State private var phase: AppPhase = .launch

    /// Represents the current phase of app initialization
    /// - launch: Displays the launch screen with logo and branding
    /// - app: Displays the main app content (RootView)
    enum AppPhase {
        case launch
        case app
    }

    var body: some View {
        Group {
            switch phase {
            case .launch:
                LaunchScreen()
                    .accessibilityAddTraits(.isModal)
                    .transition(.move(edge: .top).combined(with: .opacity))
            case .app:
                RootView()
                    .accessibilityHidden(phase == .app)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation(.easeInOut(duration: 0.8)) {
                    phase = .app
                }
            }
        }
    }
}

#Preview {
    AppEntryView()
        .environmentObject(PreviewContainer.containerViewModel)
        .environmentObject(PreviewContainer.catalogViewModel)
        .environmentObject(PreviewContainer.sampleToastyManager)
}
