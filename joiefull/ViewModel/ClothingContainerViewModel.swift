//
//  ClothingContainerViewModel.swift
//  joiefull
//
//  Created by Julien Cotte on 19/12/2025.
//

import Combine

/// Manages the application state for clothing selection and like interactions
/// Coordinates between the UI and persistent storage for user preferences
@MainActor
final class ClothingContainerViewModel: ObservableObject {
    /// Currently selected clothing item for detail view display
    @Published var selectedItem: Clothing?

    /// Set of IDs representing clothing items that have been liked by the user
    @Published private(set) var likedItemIds: Set<Int> = []

    private let dataManager: ClothingDataManager

    init(dataManager: ClothingDataManager) {
        self.dataManager = dataManager
        self.likedItemIds = dataManager.loadLikedIds()
    }

    // MARK: - Selection

    /// Toggles the selection state of a clothing item
    /// If the item is already selected, it will be deselected; otherwise it becomes selected
    /// - Parameter item: The clothing item to toggle
    func toggleSelection(_ item: Clothing) {
        selectedItem = selectedItem?.id == item.id ? nil : item
    }

    // MARK: - Likes

    /// Checks if a clothing item is currently liked by the user
    /// - Parameter item: The clothing item to check
    /// - Returns: True if the item is liked, false otherwise
    func isLiked(_ item: Clothing) -> Bool {
        likedItemIds.contains(item.id)
    }

    /// Toggles the like status for a clothing item
    /// Updates both the UI state and persistent storage
    /// - Parameter item: The clothing item whose like status should be toggled
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
