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
            Form {
                Section(AccessibilityHandler.ShareComposer.messageFieldLabel) {
                    TextField(
                        AccessibilityHandler.ShareComposer.messageFieldLabel,
                        text: $text,
                        axis: .vertical
                    )
                    .lineLimit(3...6)
                    // ACCESSIBILITY
                    .accessibilityLabel(AccessibilityHandler.ShareComposer.messageFieldLabel)
                    .accessibilityHint(AccessibilityHandler.ShareComposer.messageFieldHint)
                }
            }
            .navigationTitle(
                AccessibilityHandler.ShareComposer.title(itemName: itemName)
            )
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(AccessibilityHandler.ShareComposer.cancelButton, action: onCancel)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(AccessibilityHandler.ShareComposer.shareButton, action: onShare)
                }
            }
        }
    }
}

#Preview {
    ShareComposerView(itemName: PreviewItems.item.name, text: .constant(""), onShare: {}, onCancel: {})
}
