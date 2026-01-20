//
//  ClothingUserData.swift
//  joiefull
//
//  Created by Julien Cotte on 19/12/2025.
//

import SwiftData

/// Represents user-specific data associated with a clothing item
/// Stores preferences such as liked status, rating, and comments using SwiftData
@Model
final class ClothingUserData {
    @Attribute(.unique)
    let clothingId: Int
    var isLiked: Bool
    var actualLikes: Int
    /// User rating from 1 to 5 - 0 means "not rated yet"
    var userRating: Int
    var userComment: String?

    init(
        clothingId: Int,
        isLiked: Bool = false,
        actualLikes: Int = 0,
        userRating: Int = 0,
        userComment: String? = nil
    ) {
        self.clothingId = clothingId
        self.isLiked = isLiked
        self.actualLikes = actualLikes
        self.userRating = userRating
        self.userComment = userComment
    }
}
