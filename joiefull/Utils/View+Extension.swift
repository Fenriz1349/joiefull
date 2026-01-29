//
//  View+Extension.swift
//  joiefull
//
//  Created by Julien Cotte on 19/12/2025.
//

import SwiftUI


extension View {

    /// Conditionally applies a transformation to the view based on a boolean condition
    /// Provides a cleaner syntax for conditional view modifiers
    /// - Parameters:
    ///   - condition: Boolean condition to evaluate
    ///   - transform: Closure that transforms the view when condition is true
    /// - Returns: The transformed view if condition is true, otherwise the original view
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

extension ClothingDetailView {
    
    /// Handle focus of VoiceOver when DetailView is open and when selectedItem si changed
    func focusSummary() {
        if UIAccessibility.isVoiceOverRunning {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                UIAccessibility.post(
                    notification: .announcement,
                    argument: AccessibilityHandler.DetailView.detailOpen(itemName: item.name)
                )
                focusOnSummary = true
            }
        }
    }
}
