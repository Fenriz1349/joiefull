//
//  SharedTestHelper.swift
//  joiefullTests
//
//  Created by Julien Cotte on 02/02/2026.
//

import XCTest
import SwiftData
@testable import joiefull

import SwiftData
@testable import joiefull

@MainActor
enum SharedTestHelper {

    /// Creates a fresh list of test items (never reused between tests).
    static func makeTestItems() -> [ClothingUserData] {
        [
            ClothingUserData(clothingId: 1, isLiked: true, userRating: 4, userComment: "Top"),
            ClothingUserData(clothingId: 2, isLiked: false, userRating: 0, userComment: nil),
            ClothingUserData(clothingId: 3, isLiked: true, userRating: 2, userComment: "Bof")
        ]
    }
}
