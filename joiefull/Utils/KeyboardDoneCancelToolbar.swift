//
//  KeyboardDoneCancelToolbar.swift
//  joiefull
//
//  Created by Julien Cotte on 30/01/2026.
//

import SwiftUI

/// ViewModifier to add as a toobar a done and a cancel button
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

    /// View extenstion to add a KeyboardDoneCancelToolbar
    /// - Parameters:
    ///   - onCancel: The function to call when cancel is pressed
    ///   - onDone: The function to call when done is pressed
    /// - Returns: The View with the toolbar set with given actions
    func keyboardDoneCancelToolbar(onCancel: @escaping () -> Void, onDone: @escaping () -> Void ) -> some View {
        modifier(KeyboardDoneCancelToolbar(onCancel: onCancel, onDone: onDone))
    }
}
