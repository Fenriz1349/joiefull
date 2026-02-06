//
//  SwiftDataClothingUserDataStore.swift
//  joiefull
//
//  Created by Julien Cotte on 06/02/2026.
//

import SwiftData

/// Low-level data access abstraction for ClothingUserData persistence.
/// Isolates SwiftData usage from the DataManager.
protocol ClothingUserDataStore {
    func fetchAll() throws -> [ClothingUserData]
    func fetchById(_ clothingId: Int) throws -> ClothingUserData?
    func insert(_ item: ClothingUserData)
    func save() throws
}

/// SwiftData-backed implementation of ClothingUserDataStore.
/// Used in production to persist user data.
struct SwiftDataClothingUserDataStore: ClothingUserDataStore {

    /// The SwiftData model context used for persistence.
    let context: ModelContext

    /// Fetches all ClothingUserData entries from SwiftData.
    func fetchAll() throws -> [ClothingUserData] {
        try context.fetch(FetchDescriptor<ClothingUserData>())
    }

    /// Fetches a ClothingUserData entry matching the given clothing ID.
    func fetchById(_ clothingId: Int) throws -> ClothingUserData? {
        let all = try fetchAll()
        return all.first(where: { $0.clothingId == clothingId })
    }

    /// Inserts a new ClothingUserData entry into SwiftData.
    func insert(_ item: ClothingUserData) {
        context.insert(item)
    }

    /// Saves pending changes to the SwiftData store.
    func save() throws {
        try context.save()
    }
}
