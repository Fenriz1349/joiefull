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

    @FocusState private var isMessageFocused: Bool
    @State private var draftBeforeEdit: String = ""

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 12) {
                Text(AccessibilityHandler.ShareComposer.messageFieldLabel)
                    .font(.headline)
                    .accessibilityAddTraits(.isHeader)

                TextField(
                    AccessibilityHandler.ShareComposer.messageFieldLabel,
                    text: $text,
                    axis: .vertical
                )
                .lineLimit(3...6)
                .textFieldStyle(.roundedBorder)
                .focused($isMessageFocused)
                .submitLabel(.done)
                .onChange(of: isMessageFocused) { _, focused in
                    if focused { draftBeforeEdit = text }
                }
                .accessibilityHint(AccessibilityHandler.ShareComposer.messageFieldHint)
                .keyboardDoneCancelToolbar(
                    onCancel: {
                        text = draftBeforeEdit
                        isMessageFocused = false
                    },
                    onDone: {
                        isMessageFocused = false
                    }
                )

                HStack {
                    Button(AccessibilityHandler.ShareComposer.cancelButton) {
                        isMessageFocused = false
                        onCancel()
                    }
                    Spacer()
                    Button(AccessibilityHandler.ShareComposer.shareButton) {
                        isMessageFocused = false
                        onShare()
                    }
                }
                .padding()
                .background(.bar)

                Spacer()
            }
            .padding()
            .navigationTitle(AccessibilityHandler.ShareComposer.title(itemName: itemName))
            .navigationBarTitleDisplayMode(.inline)
            .contentShape(Rectangle()) // IMPORTANT: make the empty area tappable
            .onTapGesture {
                isMessageFocused = false
            }
            .onAppear {
                isMessageFocused = true
            }
        }
    }
}


#Preview {
    ShareComposerView(itemName: PreviewItems.item.name, text: .constant(""), onShare: {}, onCancel: {})
}
