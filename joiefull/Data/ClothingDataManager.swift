//
//  ClothingDataManager.swift
//  joiefull
//
//  Created by Julien Cotte on 19/12/2025.
//

import Foundation
import SwiftData

@MainActor
final class ClothingDataManager {

    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func loadLikedIds() -> Set<Int> {
        let descriptor = FetchDescriptor<ClothingUserData>()
        let results = (try? context.fetch(descriptor)) ?? []
        return Set(results.filter { $0.isLiked }.map { $0.clothingId })
    }

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
