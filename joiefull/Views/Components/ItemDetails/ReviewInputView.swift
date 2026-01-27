//
//  ReviewInputView.swift
//  joiefull
//
//  Created by Julien Cotte on 18/12/2025.
//

import SwiftUI

/// Text editor for users to write reviews about clothing items
/// Shows placeholder text when empty
struct ReviewInputView: View {

    @Binding var text: String
    let maxCharacters: Int = 180

    private var remaining: Int { maxCharacters - text.count }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .topLeading) {
                if text.isEmpty {
                    Text(AccessibilityHandler.ReviewInput.placeholder)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        // ACCESSIBILITY - Hide placeholder
                        .accessibilityHidden(true)
                }

                TextEditor(text: $text)
                    .padding(12)
                    .scrollContentBackground(.hidden)
                    .onChange(of: text) { _, newValue in
                        if newValue.count > maxCharacters {
                            text = String(newValue.prefix(maxCharacters))
                        }
                    }
                    // ACCESSIBILITY
                    .accessibilityLabel(AccessibilityHandler.ReviewInput.label)
                    .accessibilityHint(AccessibilityHandler.ReviewInput.hint(maxCharacters: maxCharacters))
            }
            .frame(height: 120)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.gray.opacity(0.4), lineWidth: 1)
            )

            HStack {
                Spacer()
                Text("\(remaining) caractères restants")
                    .font(.caption)
                    .foregroundStyle(remaining < 0 ? .red : .secondary)
                    .monospacedDigit()
                    // ACCESSIBILITY - Hide because it's dynamic
                    .accessibilityHidden(true)
            }
        }
    }
}

#Preview {
    ReviewInputView(text: .constant("ceci est un commentaire très très interessant"))

    ReviewInputView(text: .constant(""))
}
