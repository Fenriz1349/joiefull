//
//  RealodButton.swift
//  joiefull
//
//  Created by Julien Cotte on 29/01/2026.
//

import SwiftUI

struct ReloadButton: View {

    let action: () -> Void

    var body: some View {
        Button(action: action ) {
            HStack {
                Image(systemName: "arrow.2.circlepath.circle")
                Text("Réessayer")
            }
            .fontWeight(.semibold)
            .padding(12)
            .background(Color.accentColor)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        // ACCESSIBILITY
        .accessibilityLabel(AccessibilityHandler.ReloadButton.label)
        .accessibilityHint(AccessibilityHandler.ReloadButton.hint)
    }
}

#Preview {
    ReloadButton(action: {})
}
