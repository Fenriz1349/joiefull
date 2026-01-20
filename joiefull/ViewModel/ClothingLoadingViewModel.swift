//
//  ClothingLoadingViewModel.swift
//  joiefull
//
//  Created by Julien Cotte on 12/12/2025.
//

import Combine
import SwiftData

/// Manages the loading and filtering of clothing items from the API
@MainActor
final class ClothingLoadingViewModel: ObservableObject {
    // MARK: - API Service

    /// Array of all loaded clothing items from the API
    @Published var clothes: [Clothing] = []

    private let service = ClothingService()
    private let dataManager: ClothingDataManager

    init(dataManager: ClothingDataManager) {
        self.dataManager = dataManager
    }

    /// Fetches clothing items from the remote API
    /// Updates the clothes array on success or logs an error on failure
    func load() async {
        do {
            clothes = try await service.fetchClothes()
            let likesDict = Dictionary(uniqueKeysWithValues: clothes.map { ($0.id, $0.likes) })
            dataManager.setAllActualLikes(likesDict)
        } catch {
            print("Erreur chargement données")
        }
    }

    /// Filters clothing items by a specific category
    /// - Parameter category: The category to filter by
    /// - Returns: An array of clothing items matching the specified category
    func clothes(for category: Category) -> [Clothing] {
        clothes.filter { $0.category == category }
    }
}
