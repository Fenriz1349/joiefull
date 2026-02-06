//
//  FakeClothingDataManager.swift
//  joiefullTests
//
//  Created by Julien Cotte on 06/02/2026.
//

@testable import joiefull

/// Fake data manager used to control success/failure deterministically.
final class FakeClothingDataManager: ClothingDataManaging {

    // Configurable outputs
    var loadLikedIdsResult: Result<Set<Int>, Error> = .success([])
    var loadRatingsResult: Result<[Int: Int], Error> = .success([:])
    var loadCommentsResult: Result<[Int: String], Error> = .success([:])

    var setLikedResult: Result<Void, Error> = .success(())
    var setRatingResult: Result<Void, Error> = .success(())
    var setCommentResult: Result<Void, Error> = .success(())

    // Call tracking
    private(set) var setLikedCalls: [(Bool, Int)] = []
    private(set) var setRatingCalls: [(Int, Int)] = []
    private(set) var setCommentCalls: [(Int, String)] = []

    func loadLikedIds() throws -> Set<Int> {
        try loadLikedIdsResult.get()
    }

    func setLiked(_ liked: Bool, for clothingId: Int) throws {
        setLikedCalls.append((liked, clothingId))
        try setLikedResult.get()
    }

    func loadRatings() throws -> [Int: Int] {
        try loadRatingsResult.get()
    }

    func setRating(for clothingId: Int, _ rating: Int) throws {
        setRatingCalls.append((clothingId, rating))
        try setRatingResult.get()
    }

    func loadComments() throws -> [Int: String] {
        try loadCommentsResult.get()
    }

    func setComment(for clothingId: Int, _ comment: String) throws {
        setCommentCalls.append((clothingId, comment))
        try setCommentResult.get()
    }
}
