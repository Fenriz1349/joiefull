//
//  ClothingContainerViewModel.swift
//  joiefull
//
//  Created by Julien Cotte on 19/12/2025.
//

import Combine

@MainActor
final class ClothingContainerViewModel: ObservableObject {
    @Published var selectedItem: Clothing?
    @Published private(set) var likedItemIds: Set<Int> = []

    private let dataManager: ClothingDataManager

    init(dataManager: ClothingDataManager) {
        self.dataManager = dataManager
        self.likedItemIds = dataManager.loadLikedIds()
    }

    // MARK: - Selection

    func toggleSelection(_ item: Clothing) {
        selectedItem = selectedItem?.id == item.id ? nil : item
    }

    // MARK: - Likes

    func isLiked(_ item: Clothing) -> Bool {
        likedItemIds.contains(item.id)
    }

    func toggleLike(for item: Clothing) {
        let newValue = !isLiked(item)
        dataManager.setLiked(newValue, for: item.id)

        if newValue {
            likedItemIds.insert(item.id)
        } else {
            likedItemIds.remove(item.id)
        }
    }
}
