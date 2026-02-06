//
//  SharedTestHelper.swift
//  joiefullTests
//
//  Created by Julien Cotte on 02/02/2026.
//

@testable import joiefull

enum SharedTestHelper {

    // MARK: - Clothing fixtures

    static func picture(url: String = "https://example.com/img.png", description: String = "Image") -> Picture {
        Picture(url: url, description: description)
    }

    static func clothing(
        id: Int,
        name: String,
        category: Category,
        likes: Int = 0,
        price: Double = 10,
        originalPrice: Double = 10,
        picture: Picture = SharedTestHelper.picture()
    ) -> Clothing {
        Clothing(
            id: id,
            picture: picture,
            name: name,
            category: category,
            likes: likes,
            price: price,
            originalPrice: originalPrice
        )
    }

    static func sampleClothes() -> [Clothing] {
        [
            clothing(id: 1, name: "Pull", category: .tops),
            clothing(id: 2, name: "Jean", category: .bottoms),
            clothing(id: 3, name: "Chaussures de sport", category: .shoes),
            clothing(id: 4, name: "Sac", category: .accessories),
        ]
    }

    /// Creates a fresh list of test items (never reused between tests).
    static func makeTestItems() -> [ClothingUserData] {
        [
            ClothingUserData(clothingId: 1, isLiked: true, userRating: 4, userComment: "Top"),
            ClothingUserData(clothingId: 2, isLiked: false, userRating: 0, userComment: nil),
            ClothingUserData(clothingId: 3, isLiked: true, userRating: 2, userComment: "Bof")
        ]
    }
}
