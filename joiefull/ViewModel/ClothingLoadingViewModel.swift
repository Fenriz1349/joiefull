//
//  ClothingLoadingViewModel.swift
//  joiefull
//
//  Created by Julien Cotte on 12/12/2025.
//

import Combine
import SwiftData

@MainActor
final class ClothingLoadingViewModel: ObservableObject {
    // MARK: - API Service

    @Published var clothes: [Clothing] = []

    private let service = ClothingService()

    func load() async {
        do {
            clothes = try await service.fetchClothes()
        } catch {
            print("Erreur chargement données")
        }
    }

    func clothes(for category: Category) -> [Clothing] {
        clothes.filter { $0.category == category }
    }
}
