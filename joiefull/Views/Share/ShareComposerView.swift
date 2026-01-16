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
                Section("Message") {
                    TextField("Ajoutez un commentaire...", text: $text, axis: .vertical)
                        .lineLimit(3...6)
                }
            }
            .navigationTitle(itemName)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", action: onCancel)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Share", action: onShare)
                }
            }
        }
    }
}


#Preview {
    ShareComposerView(itemName: PreviewItems.item.name, text: .constant(""), onShare: {}, onCancel: {})
}
