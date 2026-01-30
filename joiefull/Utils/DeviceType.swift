//
//  DeviceType.swift
//  joiefull
//
//  Created by Julien Cotte on 23/01/2026.
//

import UIKit

/// Helper to get the current device and if it allow or not SplitView on the RootView
enum DeviceType {

    case iPhone
    case iPad

    static var current: DeviceType {
        UIDevice.current.userInterfaceIdiom == .pad ? .iPad : .iPhone
    }

    static var isSplitViewEnabled: Bool { current == .iPad }
}
