//
//  ClothingContainerViewModel.swift
//  joiefull
//
//  Created by Julien Cotte on 19/12/2025.
//

import Combine
import SwiftUI

/// Manages the application state for clothing selection and like interactions
/// Coordinates between the UI and persistent storage for user preferences
@MainActor
final class ClothingContainerViewModel: ObservableObject {
    /// Currently selected clothing item for detail view display
    @Published var selectedItem: Clothing?

    /// Set of IDs representing clothing items that have been liked by the user
    @Published private(set) var likedItemIds: Set<Int> = []

    /// Array of Dictionnary of IDs representing clothing items with their rating
    @Published private(set) var ratingsById: [Int: Int] = [:]
    
    /// Array of Dictionnary of IDs representing clothing items with their comment
    @Published private(set) var commentsById: [Int: String] = [:]

    /// Current share payload to present the Share Sheet
    @Published var sharePayload: SharePayload?
    @Published var shareNoteDraft: String = ""
    @Published var isShareComposerPresented = false

    private let dataManager: ClothingDataManager

    init(dataManager: ClothingDataManager) {
        self.dataManager = dataManager
        self.likedItemIds = dataManager.loadLikedIds()
        self.ratingsById = dataManager.loadRatings()
        self.commentsById = dataManager.loadComments()
    }

    // MARK: - Selection

    /// Toggles the selection state of a clothing item
    /// If the item is already selected, it will be deselected; otherwise it becomes selected
    /// - Parameter item: The clothing item to toggle
    func toggleSelection(_ item: Clothing) {
        selectedItem = selectedItem?.id == item.id ? nil : item
    }

    // MARK: - Likes

    /// Retrieves the displayed number of likes for a clothing item
    /// - Parameter item: The clothing item to get likes for
    /// - Returns: The current like count from persistent storage
    func getdisplayedLikes(for item: Clothing) -> Int {
        isLiked(item) ? item.likes + 1 : item.likes
    }

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

    // MARK: - Rating

    /// Get the rating of an item from the persistent storage
    /// - Parameter item: The Item we want the rating
    /// - Returns:
    func getRating(for item: Clothing) -> Int {
        ratingsById[item.id] ?? 0
    }

    /// Set new rating for a clothing item
    /// Updates both the UI state and persistent storage
    /// - Parameter item: The clothing item whose like status should be toggled
    func setNewRating(for item: Clothing, rating: Int) {
        guard (1...5).contains(rating), getRating(for: item) != rating else { return }

        dataManager.setRating(for: item.id, rating)
        ratingsById[item.id] = rating
    }

    /// Return the selectedItem global rating or its average with the item rating
    func getCalculatedRating (_ item: Clothing) -> Double {
        let itemRating = Double(getRating(for: item))
        return itemRating == 0 ? item.globalRating : (item.globalRating * 0.9 + itemRating * 0.1)
    }
    
    // MARK: - Comment

    /// Get the comment of an item from the persistent storage
    /// - Parameter item: The Item we want the rating
    /// - Returns:
    func getComment(for item: Clothing) -> String {
        commentsById[item.id] ?? ""
    }

    /// Set new coment for a clothing item
    /// Updates both the UI state and persistent storage
    /// - Parameter item: The clothing item whose comment should be updated
    func setNewComment(for item: Clothing, comment: String) {
        dataManager.setComment(for: item.id, comment)
        commentsById[item.id] = comment
    }
    
    /// Returns a binding to the comment associated with a clothing item
    /// - Parameter item: The clothing item to retrieve and update the comment for
    /// - Returns: A binding used to read and persist the comment text
    func commentTextBinding(for item: Clothing) -> Binding<String> {
        Binding<String>(
            get: { self.getComment(for: item) },
            set: { self.setNewComment(for: item, comment: $0) }
        )
    }

    // MARK: - Share

    /// Builds and stores a share payload for a clothing item.
    /// - Parameters:
    ///   - item: The clothing item to share.
    ///   - shareNote: Optional user-provided note to include in the shared content.
    /// - Note: If `shareNote` is empty, a default message is used.
    /// - Result: Updates `sharePayload` with a ready-to-share item (text + image URL).
    func makeSharePayload(for item: Clothing, shareNote: String) {
        let url = URL(string: item.picture.url)

        let note = shareNote.trimmingCharacters(in: .whitespacesAndNewlines)
        let defaultNote = "Voici un article que j'ai vraiment adoré! 👇"

        let message: String
        if note.isEmpty {
            message = "\(item.name)\n\n\(defaultNote)"
        } else {
            message = "\(item.name)\n\n\(note)"
        }

        let source = ShareItemSource(subject: item.name, message: message, url: url)
        sharePayload = SharePayload(items: [source])
    }
}
