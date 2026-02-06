//
//  ClothingUserDataTests.swift
//  joiefullTests
//
//  Created by Julien Cotte on 02/02/2026.
//

import XCTest
@testable import joiefull

final class ClothingUserDataTests: XCTestCase {

    func test_init_setsAllProperties() {
        let sut = ClothingUserData(clothingId: 10, isLiked: true, userRating: 5, userComment: "OK")

        XCTAssertEqual(sut.clothingId, 10)
        XCTAssertTrue(sut.isLiked)
        XCTAssertEqual(sut.userRating, 5)
        XCTAssertEqual(sut.userComment, "OK")
    }

    func test_init_defaultsAreExpected() {
        let sut = ClothingUserData(clothingId: 99)

        XCTAssertEqual(sut.clothingId, 99)
        XCTAssertFalse(sut.isLiked)
        XCTAssertEqual(sut.userRating, 0)
        XCTAssertNil(sut.userComment)
    }
}
