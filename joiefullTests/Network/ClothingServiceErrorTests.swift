//
//  ClothingServiceErrorTests.swift
//  joiefullTests
//
//  Created by Julien Cotte on 02/02/2026.
//

import XCTest
@testable import joiefull

final class ClothingServiceErrorTests: XCTestCase {

    func test_errorDescription_matchesCases() {
        XCTAssertEqual(ClothingServiceError.invalidResponse.errorDescription, "Réponse serveur invalide.")
        XCTAssertEqual(ClothingServiceError.invalidURL.errorDescription, "adresse URL invalide.")
        XCTAssertEqual(ClothingServiceError.httpStatus(404).errorDescription, "Erreur serveur (HTTP 404).")
        XCTAssertEqual(ClothingServiceError.network.errorDescription, "Impossible de charger les données. Vérifie ta connexion Internet.")
        XCTAssertEqual(ClothingServiceError.decoding.errorDescription, "Données reçues invalides (décodage impossible).")
    }
}
