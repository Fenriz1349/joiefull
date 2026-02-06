//
//  ClothingContainerViewModel.swift
//  joiefull
//
//  Created by Julien Cotte on 19/12/2025.
//

import Combine
import SwiftUI
import Toasty

/// Manages the application state for clothing selection and like interactions
/// Coordinates between the UI and persistent storage for user preferences
@MainActor
final class ClothingContainerViewModel: ObservableObject {

    @Published var toastyManager: ToastyManager?

    /// Currently displayed detail panel (selection state)
    /// Triggers split-view activation on iPad when non-nil
    @Published var selectedItem: Clothing?

    /// Set of liked item IDs, persisted to SwiftData
    /// Used to display hearts as filled and increment like count
    @Published private(set) var likedItemIds: Set<Int> = []

    /// User ratings per item (1-5), persisted to SwiftData
    /// 0 = not rated yet
    @Published private(set) var ratingsByItemId: [Int: Int] = [:]

    /// User-written reviews per item, persisted to SwiftData
    /// Max 180 characters enforced by ReviewInputView
    @Published private(set) var commentsByItemId: [Int: String] = [:]

    /// Payload for native iOS share sheet (triggered by ShareButton)
    @Published var sharePayload: SharePayload?

    /// Draft text in share composer (cleared after sharing)
    @Published var shareNoteDraft: String = ""

    /// Controls presentation of share composer modal
    @Published var isShareComposerPresented = false

    private let dataManager: ClothingDataManaging

    init(dataManager: ClothingDataManaging) {
        self.dataManager = dataManager
        loadUserData()
    }

    /// Configures the toast notification manager
    /// - Parameter toastyManager: Manager for displaying toast notifications
    func configure(toastyManager: ToastyManager) {
        self.toastyManager = toastyManager
    }

    // MARK: - User Data Loader

    /// Loads user data from SwiftData.
    func loadUserData() {
        do {
            likedItemIds = try dataManager.loadLikedIds()
            ratingsByItemId = try dataManager.loadRatings()
            commentsByItemId = try dataManager.loadComments()
        } catch {
            toastyManager?.showError(error)
        }
    }

    // MARK: - Selection

    /// Toggles the selection state of a clothing item
    /// If the item is already selected, it will be deselected; otherwise it becomes selected
    /// - Parameter item: The clothing item to toggle
    func toggleSelection(_ item: Clothing) {
        selectedItem = selectedItem?.id == item.id ? nil : item
    }

    /// Return true only if deviceType is iPad and one item is selected
    var isSplitted: Bool {
        DeviceType.isSplitViewEnabled && selectedItem != nil
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
        do {
            let newValue = !isLiked(item)
            try dataManager.setLiked(newValue, for: item.id)

            if newValue {
                likedItemIds.insert(item.id)
            } else {
                likedItemIds.remove(item.id)
            }
        } catch {
            toastyManager?.showError(error)
        }
    }

    // MARK: - Rating

    /// Get the rating of an item from the persistent storage
    /// - Parameter item: The Item we want the rating
    /// - Returns:
    func getRating(for item: Clothing) -> Int {
        ratingsByItemId[item.id] ?? 0
    }

    /// Set new rating for a clothing item
    /// Updates both the UI state and persistent storage
    /// - Parameter item: The clothing item whose like status should be toggled
    func setNewRating(for item: Clothing, rating: Int) {
        guard (1...5).contains(rating), getRating(for: item) != rating else { return }
        do {
            try dataManager.setRating(for: item.id, rating)
            ratingsByItemId[item.id] = rating
        } catch {
            toastyManager?.showError(error)
        }
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
        commentsByItemId[item.id] ?? ""
    }

    /// Set new coment for a clothing item
    /// Updates both the UI state and persistent storage
    /// - Parameter item: The clothing item whose comment should be updated
    func setNewComment(for item: Clothing, comment: String) {
        do {
            try dataManager.setComment(for: item.id, comment)
            commentsByItemId[item.id] = comment
        } catch {
            toastyManager?.showError(error)
        }
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
