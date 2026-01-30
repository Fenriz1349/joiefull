//
//  KeyboardDoneCancelToolbar.swift
//  joiefull
//
//  Created by Julien Cotte on 30/01/2026.
//

import SwiftUI

struct KeyboardDoneCancelToolbar: ViewModifier {
    let onCancel: () -> Void
    let onDone: () -> Void

    func body(content: Content) -> some View {
        content.toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Button("Annuler", action: onCancel)
                Spacer()
                Button("Terminé", action: onDone)
            }
        }
    }
}

extension View {
    func keyboardDoneCancelToolbar(
        onCancel: @escaping () -> Void,
        onDone: @escaping () -> Void
    ) -> some View {
        modifier(KeyboardDoneCancelToolbar(onCancel: onCancel, onDone: onDone))
    }
}
