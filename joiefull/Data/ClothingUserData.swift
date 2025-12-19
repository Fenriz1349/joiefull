//
//  ClothingUserData.swift
//  joiefull
//
//  Created by Julien Cotte on 19/12/2025.
//

import SwiftData

@Model
final class ClothingUserData {
    @Attribute(.unique)
    let clothingId: Int

    var isLiked: Bool
    var userRating: Int
    var userComment: String?

    init(
        clothingId: Int,
        isLiked: Bool = false,
        userRating: Int = 0,
        userComment: String? = nil
    ) {
        self.clothingId = clothingId
        self.isLiked = isLiked
        self.userRating = userRating
        self.userComment = userComment
    }
}
