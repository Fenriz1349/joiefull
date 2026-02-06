//
//  ClothingDataManagerErrorTests.swift
//  joiefullTests
//
//  Created by Julien Cotte on 02/02/2026.
//

import XCTest
@testable import joiefull

final class ClothingDataManagerErrorTests: XCTestCase {

    /// Ensures errors are equatable by case.
    func test_equatable_comparesCases() {
        XCTAssertEqual(ClothingDataManagerError.fetchFailed, .fetchFailed)
        XCTAssertEqual(ClothingDataManagerError.saveFailed, .saveFailed)
        XCTAssertEqual(ClothingDataManagerError.loadFailed, .loadFailed)

        XCTAssertNotEqual(ClothingDataManagerError.fetchFailed, .saveFailed)
        XCTAssertNotEqual(ClothingDataManagerError.saveFailed, .loadFailed)
        XCTAssertNotEqual(ClothingDataManagerError.loadFailed, .fetchFailed)
    }

    /// Returns the expected localized description for fetchFailed.
    func test_errorDescription_fetchFailed() {
        XCTAssertEqual(
            ClothingDataManagerError.fetchFailed.errorDescription,
            "Erreur lors de la lecture des données locales."
        )
    }

    /// Returns the expected localized description for saveFailed.
    func test_errorDescription_saveFailed() {
        XCTAssertEqual(
            ClothingDataManagerError.saveFailed.errorDescription,
            "Erreur lors de l’enregistrement des données locales."
        )
    }

    /// Returns the expected localized description for loadFailed.
    func test_errorDescription_loadFailed() {
        XCTAssertEqual(
            ClothingDataManagerError.loadFailed.errorDescription,
            "Erreur lors de la lecture des données locales."
        )
    }
}

