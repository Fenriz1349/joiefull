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

    /// Fetches all clothing IDs that have been marked as liked by the user
    /// - Returns: A set containing the IDs of all liked clothing items
    func loadLikedIds() -> Set<Int> {
        let descriptor = FetchDescriptor<ClothingUserData>()
        let results = (try? context.fetch(descriptor)) ?? []
        return Set(results.filter { $0.isLiked }.map { $0.clothingId })
    }

    /// Updates the liked status for a specific clothing item
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
    }
}
