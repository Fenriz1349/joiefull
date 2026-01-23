//
//  ShareComposerView.swift
//  joiefull
//
//  Created by Julien Cotte on 16/01/2026.
//

import SwiftUI

struct ShareComposerView: View {
    let itemName: String
    @Binding var text: String
    let onShare: () -> Void
    let onCancel: () -> Void

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 12) {
                Text(AccessibilityHandler.ShareComposer.messageFieldLabel)
                    .font(.headline)

                TextField(
                    AccessibilityHandler.ShareComposer.messageFieldLabel,
                    text: $text,
                    axis: .vertical
                )
                .lineLimit(3...6)
                .textFieldStyle(.roundedBorder)
                .accessibilityHint(AccessibilityHandler.ShareComposer.messageFieldHint)
                HStack {
                    Button(AccessibilityHandler.ShareComposer.cancelButton, action: onCancel)
                    Spacer()
                    Button(AccessibilityHandler.ShareComposer.shareButton, action: onShare)
                }
                .padding()
                .background(.bar)

                Spacer()
            }
            .padding()
            .navigationTitle(AccessibilityHandler.ShareComposer.title(itemName: itemName))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ShareComposerView(itemName: PreviewItems.item.name, text: .constant(""), onShare: {}, onCancel: {})
}
