//
//  SharePayload.swift
//  joiefull
//
//  Created by Julien Cotte on 16/01/2026.
//

import Foundation

/// Simple model describing what should be shared
struct SharePayload: Identifiable {

    let id = UUID()
    let items: [Any]
}
