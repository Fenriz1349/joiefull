//
//  ClothingServiceError.swift
//  joiefull
//
//  Created by Julien Cotte on 23/01/2026.
//

import Foundation

enum ClothingServiceError: Error, Equatable, LocalizedError {

    case invalidResponse
    case httpStatus(Int)
    case network
    case decoding

    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "Réponse serveur invalide."
        case .httpStatus(let code):
            return "Erreur serveur (HTTP \(code))."
        case .network:
            return "Impossible de charger les données. Vérifie ta connexion Internet."
        case .decoding:
            return "Données reçues invalides (décodage impossible)."
        }
    }
}
