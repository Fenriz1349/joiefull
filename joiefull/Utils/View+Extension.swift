//
//  View+Extension.swift
//  joiefull
//
//  Created by Julien Cotte on 19/12/2025.
//

import SwiftUI

/// Conditionally applies a transformation to the view based on a boolean condition
/// Provides a cleaner syntax for conditional view modifiers
/// - Parameters:
///   - condition: Boolean condition to evaluate
///   - transform: Closure that transforms the view when condition is true
/// - Returns: The transformed view if condition is true, otherwise the original view
extension View {

    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
