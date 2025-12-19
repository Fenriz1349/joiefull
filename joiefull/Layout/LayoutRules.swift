//
//  LayoutRules.swift
//  joiefull
//
//  Created by Julien Cotte on 19/12/2025.
//

import Foundation

enum LayoutRules {
    static func allowsSplit(_ size: CGSize) -> Bool {
        size.width >= 700 && size.width > size.height
    }

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
