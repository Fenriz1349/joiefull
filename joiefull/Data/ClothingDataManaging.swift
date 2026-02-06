//
//  ClothingDataManaging.swift
//  joiefull
//
//  Created by Julien Cotte on 06/02/2026.
//

/// Abstraction layer used by ViewModels to access user clothing data.
/// Allows dependency injection and easier testing.
protocol ClothingDataManaging {

    func loadLikedIds() throws -> Set<Int>
    func setLiked(_ liked: Bool, for clothingId: Int) throws

    func loadRatings() throws -> [Int: Int]
    func setRating(for clothingId: Int, _ rating: Int) throws

    func loadComments() throws -> [Int: String]
    func setComment(for clothingId: Int, _ comment: String) throws
}
