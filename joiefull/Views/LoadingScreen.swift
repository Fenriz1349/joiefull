//
//  LoadingScreen.swift
//  joiefull
//
//  Created by Julien Cotte on 23/01/2026.
//

import SwiftUI

struct LoadingScreen: View {
    var body: some View {
        ZStack {
            Rectangle()
                .ignoresSafeArea()
                .foregroundColor(.launchBackground)
            VStack(spacing: 24) {
                Image(.launchLogo)
                    .padding(.vertical, 48)
                ProgressView("Chargement…")
                    .accessibilityLabel(AccessibilityHandler.Loading.label)
                    .accessibilityHint(AccessibilityHandler.Loading.hint)
            }
        }
       
    }
}

#Preview {
    LoadingScreen()
}
