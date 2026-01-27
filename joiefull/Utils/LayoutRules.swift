//
//  LayoutRules.swift
//  joiefull
//
//  Created by Julien Cotte on 19/12/2025.
//

import Foundation

/// Provides layout decision logic based on screen dimensions
/// Determines responsive layout behaviors for different device sizes and orientations
import SwiftUI

enum LayoutRules {

    /// Returns true when the available space is wider than tall
    /// Used to detect landscape-like layouts.
    static func isLandscape(_ size: CGSize) -> Bool {
        size.width > size.height
    }

    /// Returns the main split layout (horizontal or vertical)
    /// based on the current orientation.
    static func splitLayout(for size: CGSize) -> AnyLayout {
        isLandscape(size)
        ? AnyLayout(HStackLayout(spacing: 0))
        : AnyLayout(VStackLayout(spacing: 0))
    }

    /// Computes the frame for the list when split mode is active.
    /// Uses 2/3 of width (landscape) or height (portrait).
    static func listFrame(in size: CGSize, allowsSplit: Bool, hasSelection: Bool) -> CGSize {
        guard allowsSplit, hasSelection else { return size }

        if isLandscape(size) {
            return CGSize(width: size.width * 2 / 3, height: size.height)
        } else {
            return CGSize(width: size.width, height: size.height * 2 / 3)
        }
    }

    /// Computes the frame for the detail view when split mode is active.
    /// Uses 1/3 of width (landscape) or height (portrait).
    static func detailFrame(in size: CGSize, allowsSplit: Bool, hasSelection: Bool) -> CGSize {
        guard allowsSplit, hasSelection else { return .zero }

        if isLandscape(size) {
            return CGSize(width: size.width / 3, height: size.height)
        } else {
            return CGSize(width: size.width, height: size.height / 3)
        }
    }

    /// Returns the layout for the detail screen content
    /// based on device type and orientation.
    static func getDetailViewLayout(_ size: CGSize) -> AnyLayout {
        let isLandscape = size.width > size.height
        let hStack: Bool = (DeviceType.current == .iPad && isLandscape)
        || (DeviceType.current == .iPhone && isLandscape)
        return hStack ? AnyLayout(HStackLayout(alignment: .top, spacing: 20))
        : AnyLayout(VStackLayout(alignment: .leading, spacing: 20))
    }

    /// Calculates the optimal number of items to display per row based on available width
    /// - Parameter width: The available width in points
    /// - Returns: Number of items (1, 2, 3, or 5) based on width
    static func itemCount(for width: CGFloat) -> Int {
        switch width {
        case 0..<360: return 1
        case 360..<600: return 2
        case 600..<900: return 3
        default: return 5
        }
    }
}
