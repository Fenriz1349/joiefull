//
//  LayoutRules.swift
//  joiefull
//
//  Created by Julien Cotte on 19/12/2025.
//

import Foundation

/// Provides layout decision logic based on screen dimensions
/// Determines responsive layout behaviors for different device sizes and orientations
enum LayoutRules {
    /// Determines if the screen is large enough to display a split view layout
    /// - Parameter size: The current screen size
    /// - Returns: True if width is at least 700 points and wider than tall (landscape)
    static func allowsSplit(_ size: CGSize) -> Bool {
        size.width >= 700 && size.width > size.height
    }

    /// Determines if detail view should use landscape-specific layout
    /// - Parameters:
    ///   - size: The current screen size
    ///   - isCompact: Whether the size class is compact
        /// - Returns: True if in compact mode and landscape orientation
    static func usesLandscapeDetailLayout(size: CGSize, isCompact: Bool) -> Bool {
        isCompact && size.width > size.height
    }

    /// Calculates the optimal number of items to display per row based on available width
    /// - Parameter width: The available width in points
    /// - Returns: Number of items (1, 2, 3, or 5) based on width breakpoints
    static func itemCount(for width: CGFloat) -> Int {
        switch width {
        case 0..<360:
            return 1
        case 360..<600:
            return 2
        case 600..<900:
            return 3
        default:
            return 5
        }
    }
}
