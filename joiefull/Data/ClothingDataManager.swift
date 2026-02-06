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
final class ClothingDataManager: ClothingDataManaging {

    /// Data store responsible for persistence operations.
    private let store: ClothingUserDataStore

    /// Creates a data manager backed by a SwiftData context.
    /// - Parameter context: The SwiftData model context.
    convenience init(context: ModelContext) {
        self.init(store: SwiftDataClothingUserDataStore(context: context))
    }

    /// Designated initializer allowing dependency injection.
    /// - Parameter store: The data store used for persistence.
    init(store: ClothingUserDataStore) {
        self.store = store
    }

    // MARK: - Likes

    /// Fetches all clothing IDs that have been marked as liked by the user
    /// - Throws: ClothingDataManagerError
    /// - Returns: A set containing the IDs of all liked clothing items
    func loadLikedIds() throws -> Set<Int> {
        do {
            let results = try store.fetchAll()
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
        let data: ClothingUserData
        do {
            if let existing = try store.fetchById(clothingId) {
                data = existing
            } else {
                data = ClothingUserData(clothingId: clothingId)
                store.insert(data)
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
        do {
            let results = try store.fetchAll()
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
        let data: ClothingUserData
        do {
            if let existing = try store.fetchById(clothingId) {
                data = existing
            } else {
                data = ClothingUserData(clothingId: clothingId)
                store.insert(data)
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
        do {
            let results = try store.fetchAll()
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
        let data: ClothingUserData
        do {
            if let existing = try store.fetchById(clothingId) {
                data = existing
            } else {
                data = ClothingUserData(clothingId: clothingId)
                store.insert(data)
            }
        } catch {
            throw ClothingDataManagerError.fetchFailed
        }

        data.userComment = comment
        try safeSave()
    }
}

extension ClothingDataManager {

    /// helpers to save or throwing error
    private func safeSave() throws {
        do {
            try store.save()
        } catch {
            throw ClothingDataManagerError.saveFailed
        }
    }
}
