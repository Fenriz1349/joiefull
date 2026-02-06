//
//  ClothingModelsTests.swift
//  joiefullTests
//
//  Created by Julien Cotte on 06/02/2026.
//

import XCTest
@testable import joiefull

final class ClothingModelsTests: XCTestCase {

    // MARK: - Clothing.globalRating

    /// Returns expected hardcoded ratings for known ids.
    func test_clothing_globalRating_knownIds() {
        XCTAssertEqual(SharedTestHelper.clothing(id: 0, name: "Item", category: .tops).globalRating, 3.9)
        XCTAssertEqual(SharedTestHelper.clothing(id: 6, name: "Item", category: .tops).globalRating, 0.0)
        XCTAssertEqual(SharedTestHelper.clothing(id: 11, name: "Item", category: .tops).globalRating, 4.4)
    }

    /// Returns default rating for unknown ids.
    func test_clothing_globalRating_unknownId_returnsDefault() {
        XCTAssertEqual(SharedTestHelper.clothing(id: 999, name: "Item", category: .tops).globalRating, 4.1)
    }

    // MARK: - Clothing.descriptionText

    /// Uses specific description when available (only checks prefix).
    func test_clothing_descriptionText_knownId_startsWithExpectedText() {
        let clothing = SharedTestHelper.clothing(id: 0, name: "Item", category: .accessories)

        XCTAssertTrue(
            clothing.descriptionText
                .trimmingCharacters(in: .whitespacesAndNewlines)
                .hasPrefix("Sac à main orange en cuir lisse")
        )
    }

    /// Uses default description when id is unknown (only checks prefix).
    func test_clothing_descriptionText_unknownId_usesDefaultDescription() {
        let clothing = SharedTestHelper.clothing(id: 999, name: "Item", category: .tops)

        XCTAssertTrue(
            clothing.descriptionText
                .trimmingCharacters(in: .whitespacesAndNewlines)
                .hasPrefix("Pièce essentielle au design soigné")
        )
    }

    // MARK: - Category.title

    /// Returns expected localized title for each category.
    func test_category_title_returnsExpectedValue() {
        XCTAssertEqual(Category.tops.title, "Hauts")
        XCTAssertEqual(Category.bottoms.title, "Bas")
        XCTAssertEqual(Category.shoes.title, "Chaussures")
        XCTAssertEqual(Category.accessories.title, "Sacs & Accessoires")
    }

    // MARK: - EmptyListDisplay

    /// Builds correct display for empty catalog state.
    func test_emptyListDisplay_emptyCatalog_returnsExpectedContent() {
        let display = EmptyListDisplay.display(for: .emptyCatalog)

        XCTAssertEqual(display.image, "tray")
        XCTAssertEqual(display.title, "Catalogue vide")
        XCTAssertEqual(display.message, "Aucun article n’est disponible pour le moment.")
        XCTAssertEqual(display.accessibilityMessage, AccessibilityHandler.EmptyState.catalogEmptyLabel)
        XCTAssertEqual(display.accessibilityHint, AccessibilityHandler.EmptyState.catalogEmptyHint)
    }

    /// Builds correct display for empty search state.
    func test_emptyListDisplay_emptySearch_returnsExpectedContent() {
        let display = EmptyListDisplay.display(for: .emptySearch)

        XCTAssertEqual(display.image, "magnifyingglass")
        XCTAssertEqual(display.title, "Aucun résultat")
        XCTAssertEqual(display.message, "Aucun article ne correspond à votre recherche.")
        XCTAssertEqual(display.accessibilityMessage, AccessibilityHandler.EmptyState.noResultsLabel)
        XCTAssertEqual(display.accessibilityHint, AccessibilityHandler.EmptyState.noResultsHint)
    }
}
