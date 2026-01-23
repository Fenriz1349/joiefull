//
//  ClothingDataManager.swift
//  joiefull
//
//  Created by Julien Cotte on 19/12/2025.
//

import Foundation
import SwiftData

/// Manages persistent storage operations for clothing user data
/// Handles liked status and user interactions with clothing items using SwiftData
@MainActor
final class ClothingDataManager {

    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    // MARK: - Likes

    /// Retrieves the displayed number of likes for a specific clothing item
    /// - Parameter clothingId: The unique identifier of the clothing item
    /// - Returns: The number of likes stored in the database, or 0 if not found
    func getdisplayedLikes(for clothingId: Int) -> Int {
        let descriptor = FetchDescriptor<ClothingUserData>(
            predicate: #Predicate { $0.clothingId == clothingId }
        )

        if let data = try? context.fetch(descriptor).first {
            return data.displayedLikes
        }

        return 0
    }

    /// Updates the displayed likes count for a specific clothing item
    /// Creates a new record if the clothing item doesn't exist in the database
    /// - Parameters:
    ///   - clothingId: The unique identifier of the clothing item
    ///   - likes: The new like count to store
    private func setDisplayedLikes(for clothingId: Int, likes: Int) {
        let descriptor = FetchDescriptor<ClothingUserData>(
            predicate: #Predicate { $0.clothingId == clothingId }
        )

        let data: ClothingUserData
        if let existing = try? context.fetch(descriptor).first {
            data = existing
        } else {
            data = ClothingUserData(clothingId: clothingId)
            context.insert(data)
        }

        data.displayedLikes = likes
        try? context.save()
    }

    /// Bulk updates the displayed like count for multiple clothing items
    /// - Parameter likes: A dictionary mapping clothing IDs to their like counts
    func setAllDisplayedLikes(_ likes: [Int: Int]) {
        likes.forEach {
            setDisplayedLikes(for: $0.key, likes: $0.value)
        }
    }

    /// Fetches all clothing IDs that have been marked as liked by the user
    /// - Returns: A set containing the IDs of all liked clothing items
    func loadLikedIds() -> Set<Int> {
        let descriptor = FetchDescriptor<ClothingUserData>()
        let results = (try? context.fetch(descriptor)) ?? []
        return Set(results.filter { $0.isLiked }.map { $0.clothingId })
    }

    /// Updates the liked status and the displayedLikes for a specific clothing item
    /// Creates a new record if the clothing item doesn't exist in the database
    /// - Parameters:
    ///   - liked: The new liked status (true for liked, false for unliked)
    ///   - clothingId: The unique identifier of the clothing item
    func setLiked(_ liked: Bool, for clothingId: Int) {
        let descriptor = FetchDescriptor<ClothingUserData>(
            predicate: #Predicate { $0.clothingId == clothingId }
        )

        let data: ClothingUserData
        if let existing = try? context.fetch(descriptor).first {
            data = existing
        } else {
            data = ClothingUserData(clothingId: clothingId)
            context.insert(data)
        }

        data.isLiked = liked
        data.displayedLikes += liked ? 1 : -1
        try? context.save()
    }

    // MARK: - Rating

    /// Fetches all clothing IDs with their rating
    /// - Returns: An Array of all item and their rating
    func loadRatings() -> [Int: Int] {
        let descriptor = FetchDescriptor<ClothingUserData>()
        let results = (try? context.fetch(descriptor)) ?? []
        return Dictionary(uniqueKeysWithValues: results.map { ($0.clothingId, $0.userRating) })
    }

    /// Updates the rating for a specific clothing item
    /// Creates a new record if the clothing item doesn't exist in the database
    /// - Parameters:
    ///   - rating: The new rating
    ///   - clothingId: The unique identifier of the clothing item
    func setRating(for clothingId: Int, _ rating: Int) {
        let descriptor = FetchDescriptor<ClothingUserData>(
            predicate: #Predicate { $0.clothingId == clothingId }
        )

        let data: ClothingUserData
        if let existing = try? context.fetch(descriptor).first {
            data = existing
        } else {
            data = ClothingUserData(clothingId: clothingId)
            context.insert(data)
        }

        data.userRating = rating
        try? context.save()
    }

    // MARK: - Comment

    /// Fetches all clothing IDs with their comment
    /// - Returns: An Array of all item and their comment
    func loadComments() -> [Int: String] {
        let descriptor = FetchDescriptor<ClothingUserData>()
        let results = (try? context.fetch(descriptor)) ?? []
        return Dictionary(uniqueKeysWithValues: results.map { ($0.clothingId, $0.userComment ?? "") })
    }

    /// Updates the comment for a specific clothing item
    /// Creates a new record if the clothing item doesn't exist in the database
    /// - Parameters:
    ///   - comment: The new comment
    ///   - clothingId: The unique identifier of the clothing item
    func setComment(for clothingId: Int, _ comment: String) {
        let descriptor = FetchDescriptor<ClothingUserData>(
            predicate: #Predicate { $0.clothingId == clothingId }
        )

        let data: ClothingUserData
        if let existing = try? context.fetch(descriptor).first {
            data = existing
        } else {
            data = ClothingUserData(clothingId: clothingId)
            context.insert(data)
        }

        data.userComment = comment
        try? context.save()
    }
}
