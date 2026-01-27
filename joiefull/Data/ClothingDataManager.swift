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

    /// Fetches all clothing IDs that have been marked as liked by the user
    /// - Throws: ClothingDataManagerError
    /// - Returns: A set containing the IDs of all liked clothing items
    func loadLikedIds() throws -> Set<Int> {
        let descriptor = FetchDescriptor<ClothingUserData>()
        do {
            let results = try context.fetch(descriptor)
            return Set(results.filter { $0.isLiked }.map { $0.clothingId })
        } catch {
            throw ClothingDataManagerError.loadFailed
        }
    }

    /// Updates the liked status and the displayedLikes for a specific clothing item
    /// Creates a new record if the clothing item doesn't exist in the database
    /// - Parameters:
    ///   - liked: The new liked status (true for liked, false for unliked)
    ///   - clothingId: The unique identifier of the clothing item
    ///   - Throws: ClothingDataManagerError
    func setLiked(_ liked: Bool, for clothingId: Int) throws {
        let descriptor = FetchDescriptor<ClothingUserData>(
            predicate: #Predicate { $0.clothingId == clothingId }
        )

        let data: ClothingUserData
        do {
            if let existing = try context.fetch(descriptor).first {
                data = existing
            } else {
                data = ClothingUserData(clothingId: clothingId)
                context.insert(data)
            }
        } catch {
            throw ClothingDataManagerError.fetchFailed
        }

        data.isLiked = liked
        try safeSave()
    }

    // MARK: - Rating

    /// Fetches all clothing IDs with their rating
    /// - Throws: ClothingDataManagerError
    /// - Returns: An Array of all item and their rating
    func loadRatings() throws -> [Int: Int] {
        let descriptor = FetchDescriptor<ClothingUserData>()
        do {
            let results = try context.fetch(descriptor)
            return Dictionary(uniqueKeysWithValues: results.map { ($0.clothingId, $0.userRating) })
        } catch {
            throw ClothingDataManagerError.loadFailed
        }
    }

    /// Updates the rating for a specific clothing item
    /// Creates a new record if the clothing item doesn't exist in the database
    /// - Parameters:
    ///   - rating: The new rating
    ///   - clothingId: The unique identifier of the clothing item
    ///   - Throws: ClothingDataManagerError
    func setRating(for clothingId: Int, _ rating: Int) throws {
        let descriptor = FetchDescriptor<ClothingUserData>(
            predicate: #Predicate { $0.clothingId == clothingId }
        )

        let data: ClothingUserData

        do {
            if let existing = try context.fetch(descriptor).first {
                data = existing
            } else {
                data = ClothingUserData(clothingId: clothingId)
                context.insert(data)
            }
        } catch {
            throw ClothingDataManagerError.fetchFailed
        }

        data.userRating = rating
        try safeSave()
    }

    // MARK: - Comment

    /// Fetches all clothing IDs with their comment
    /// - Throws: ClothingDataManagerError
    /// - Returns: An Array of all item and their comment
    func loadComments() throws -> [Int: String] {
        let descriptor = FetchDescriptor<ClothingUserData>()
        do {
            let results = try context.fetch(descriptor)
            return Dictionary(uniqueKeysWithValues: results.map { ($0.clothingId, $0.userComment ?? "") })
        } catch {
            throw ClothingDataManagerError.loadFailed
        }
    }

    /// Updates the comment for a specific clothing item
    /// Creates a new record if the clothing item doesn't exist in the database
    /// - Parameters:
    ///   - comment: The new comment
    ///   - clothingId: The unique identifier of the clothing item
    ///   - Throws: ClothingDataManagerError
    func setComment(for clothingId: Int, _ comment: String) throws {
        let descriptor = FetchDescriptor<ClothingUserData>(
            predicate: #Predicate { $0.clothingId == clothingId }
        )

        let data: ClothingUserData

        do {
            if let existing = try context.fetch(descriptor).first {
                data = existing
            } else {
                data = ClothingUserData(clothingId: clothingId)
                context.insert(data)
            }
        } catch {
            throw ClothingDataManagerError.fetchFailed
        }

        data.userComment = comment
        try safeSave()
    }
}

extension ClothingDataManager {
    private func safeSave() throws {
        do {
            try context.save()
        } catch {
            throw ClothingDataManagerError.saveFailed
        }
    }
}
