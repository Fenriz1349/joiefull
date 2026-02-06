//
//  DeviceType.swift
//  joiefull
//
//  Created by Julien Cotte on 23/01/2026.
//

import UIKit

/// Helper to get the current device and if it allow or not SplitView on the RootView
@MainActor
enum DeviceType {

    case iPhone
    case iPad

    static var current: DeviceType {
        if let overridden = debugOverride { return overridden }
        return UIDevice.current.userInterfaceIdiom == .pad ? .iPad : .iPhone
    }

    static var isSplitViewEnabled: Bool { current == .iPad }
}

extension DeviceType {

    #if DEBUG
    /// Overrides the current device type (used for tests and previews).
    static var debugOverride: DeviceType?
    #else
    /// Always nil outside DEBUG builds.
    static var debugOverride: DeviceType? { nil }
    #endif
}
