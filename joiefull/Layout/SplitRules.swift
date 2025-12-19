//
//  SplitRules.swift
//  joiefull
//
//  Created by Julien Cotte on 19/12/2025.
//

import Foundation

enum SplitRules {
    static func allowsSplit(for width: CGFloat) -> Bool {
        width >= 700
    }
}
