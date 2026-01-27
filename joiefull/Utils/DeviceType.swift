//
//  DeviceType.swift
//  joiefull
//
//  Created by Julien Cotte on 23/01/2026.
//

import UIKit

enum DeviceType {

    case iPhone
    case iPad

    static var current: DeviceType {
        UIDevice.current.userInterfaceIdiom == .pad ? .iPad : .iPhone
    }

    static var isSplitViewEnabled: Bool { current == .iPad }
}
