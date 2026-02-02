//
//  ReviewInputView.swift
//  joiefull
//
//  Created by Julien Cotte on 18/12/2025.
//

import SwiftUI

/// Text editor for user reviews (max 180 chars).
/// Restores draft if user cancels input.
struct ReviewInputView: View {

    @Binding var text: String
    let maxCharacters: Int = 180

    @FocusState private var isReviewFocused: Bool
    var externalFocus: FocusState<Bool>.Binding?
    
    /// Text before editing (restored if keyboard cancelled).
    @State private var draftBeforeEdit: String = ""

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
                    .focused(externalFocus ?? $isReviewFocused)
                    .padding(12)
                    .scrollContentBackground(.hidden)
                    .onChange(of: text) { _, newValue in
                        if newValue.count > maxCharacters {
                            text = String(newValue.prefix(maxCharacters))
                        }
                    }
                    .onChange(of: isReviewFocused) { _, focused in
                        // Save the original text when editing starts
                        if focused { draftBeforeEdit = text }
                    }
                    .keyboardDoneCancelToolbar(
                        onCancel: {
                            text = draftBeforeEdit
                            (externalFocus ?? $isReviewFocused).wrappedValue = false
                        },
                        onDone: {
                            (externalFocus ?? $isReviewFocused).wrappedValue = false
                        }
                    )
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
        .contentShape(Rectangle())
        .onTapGesture {
            (externalFocus ?? $isReviewFocused).wrappedValue = false
        }
    }
}

#Preview {
    ReviewInputView(text: .constant("ceci est un commentaire très très interessant"))

    ReviewInputView(text: .constant(""))
}
