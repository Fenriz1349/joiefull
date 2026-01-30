//
//  ClothingDataManagerError.swift
//  joiefull
//
//  Created by Julien Cotte on 23/01/2026.
//

import Foundation

/// Handle errors when saving on SwiftData
enum ClothingDataManagerError: Error, Equatable, LocalizedError {

    case fetchFailed
    case saveFailed
    case loadFailed

    var errorDescription: String {
        switch self {
        case .fetchFailed:
            return "Erreur lors de la lecture des données locales."
        case .saveFailed:
            return "Erreur lors de l’enregistrement des données locales."
        case .loadFailed:
            return "Erreur lors de la lecture des données locales."
        }
    }
}
