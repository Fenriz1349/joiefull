//
//  BrandingContentView.swift
//  joiefull
//
//  Created by Julien Cotte on 29/01/2026.
//

import SwiftUI

/// Reusable branding view with background and logo
/// Allows injecting custom content overlay
struct BrandingContentView<Content: View>: View {

    @ViewBuilder let content: () -> Content

    var body: some View {
        GeometryReader { geo in
            ZStack {
                Rectangle()
                    .ignoresSafeArea()
                    .foregroundColor(.launchBackground)

                Image(.launchLogo)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: geo.size.width * 0.75)
                VStack(spacing: 32) {
                    Spacer()
                        .frame(height: geo.size.height * 0.5)
                    content()
                }
            }
        }
    }
}

#Preview {
    BrandingContentView()
}

#Preview("With Content") {
    BrandingContentView {
        VStack {
            Text("Ceci est un texte afin de tester l'affichage d'un contenu très interessant" )
        }
    }
}
