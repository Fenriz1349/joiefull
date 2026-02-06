//
//  ClothingDataManagerTests.swift
//  joiefullTests
//
//  Created by Julien Cotte on 02/02/2026.
//

import XCTest
@testable import joiefull

final class ClothingDataManagerTests: XCTestCase {

    // MARK: - Happy paths

    /// Returns only liked ids when fetchAll succeeds.
    func test_loadLikedIds_returnsOnlyLikedIds() async throws {
        let store = await FailingClothingUserDataStore(failure: .none, items: SharedTestHelper.makeTestItems())
        let sut = await MainActor.run { ClothingDataManager(store: store) }

        try await MainActor.run {
            let liked = try sut.loadLikedIds()
            XCTAssertEqual(liked, Set([1, 3]))
        }
    }

    /// Creates missing item and marks it as liked.
    func test_setLiked_createsItemIfNeeded_andPersistsLike() async throws {
        let store = FailingClothingUserDataStore(failure: .none, items: [])
        let sut = await MainActor.run { ClothingDataManager(store: store) }

        try await MainActor.run {
            try sut.setLiked(true, for: 10)
            let liked = try sut.loadLikedIds()
            XCTAssertEqual(liked, Set([10]))
        }
    }

    /// Returns ratings dictionary when fetchAll succeeds.
    func test_loadRatings_returnsRatingsDictionary() async throws {
        let store = await FailingClothingUserDataStore(failure: .none, items: SharedTestHelper.makeTestItems())
        let sut = await MainActor.run { ClothingDataManager(store: store) }

        try await MainActor.run {
            let ratings = try sut.loadRatings()
            XCTAssertEqual(ratings[1], 4)
            XCTAssertEqual(ratings[2], 0)
            XCTAssertEqual(ratings[3], 2)
        }
    }

    /// Creates missing item and updates its rating.
    func test_setRating_createsItemIfNeeded_andUpdatesRating() async throws {
        let store = FailingClothingUserDataStore(failure: .none, items: [])
        let sut = await MainActor.run { ClothingDataManager(store: store) }

        try await MainActor.run {
            try sut.setRating(for: 99, 5)
            let ratings = try sut.loadRatings()
            XCTAssertEqual(ratings[99], 5)
        }
    }

    /// Converts nil comments to empty strings.
    func test_loadComments_convertsNilToEmptyString() async throws {
        let store = await FailingClothingUserDataStore(failure: .none, items: SharedTestHelper.makeTestItems())
        let sut = await MainActor.run { ClothingDataManager(store: store) }

        try await MainActor.run {
            let comments = try sut.loadComments()
            XCTAssertEqual(comments[1], "Top")
            XCTAssertEqual(comments[2], "")
            XCTAssertEqual(comments[3], "Bof")
        }
    }

    /// Creates missing item and updates its comment.
    func test_setComment_createsItemIfNeeded_andUpdatesComment() async throws {
        let store = FailingClothingUserDataStore(failure: .none, items: [])
        let sut = await MainActor.run { ClothingDataManager(store: store) }

        try await MainActor.run {
            try sut.setComment(for: 77, "Hello")
            let comments = try sut.loadComments()
            XCTAssertEqual(comments[77], "Hello")
        }
    }

    // MARK: - Catch coverage: load* (fetchAll)

    /// Throws loadFailed when fetchAll fails in loadLikedIds.
    func test_loadLikedIds_whenFetchAllFails_throwsLoadFailed() async throws {
        let sut = await MainActor.run { ClothingDataManager(store: FailingClothingUserDataStore(failure: .fetchAll)) }

        try await MainActor.run {
            XCTAssertThrowsError(try sut.loadLikedIds()) { error in
                XCTAssertEqual(error as? ClothingDataManagerError, .loadFailed)
            }
        }
    }

    /// Throws loadFailed when fetchAll fails in loadRatings.
    func test_loadRatings_whenFetchAllFails_throwsLoadFailed() async throws {
        let sut = await MainActor.run { ClothingDataManager(store: FailingClothingUserDataStore(failure: .fetchAll)) }

        try await MainActor.run {
            XCTAssertThrowsError(try sut.loadRatings()) { error in
                XCTAssertEqual(error as? ClothingDataManagerError, .loadFailed)
            }
        }
    }

    /// Throws loadFailed when fetchAll fails in loadComments.
    func test_loadComments_whenFetchAllFails_throwsLoadFailed() async throws {
        let sut = await MainActor.run { ClothingDataManager(store: FailingClothingUserDataStore(failure: .fetchAll)) }

        try await MainActor.run {
            XCTAssertThrowsError(try sut.loadComments()) { error in
                XCTAssertEqual(error as? ClothingDataManagerError, .loadFailed)
            }
        }
    }

    // MARK: - Catch coverage: set* fetch (fetchById)

    /// Throws fetchFailed when fetchById fails in setLiked.
    func test_setLiked_whenFetchByIdFails_throwsFetchFailed() async throws {
        let sut = await MainActor.run { ClothingDataManager(store: FailingClothingUserDataStore(failure: .fetchById)) }

        try await MainActor.run {
            XCTAssertThrowsError(try sut.setLiked(true, for: 1)) { error in
                XCTAssertEqual(error as? ClothingDataManagerError, .fetchFailed)
            }
        }
    }

    /// Throws fetchFailed when fetchById fails in setRating.
    func test_setRating_whenFetchByIdFails_throwsFetchFailed() async throws {
        let sut = await MainActor.run { ClothingDataManager(store: FailingClothingUserDataStore(failure: .fetchById)) }

        try await MainActor.run {
            XCTAssertThrowsError(try sut.setRating(for: 1, 3)) { error in
                XCTAssertEqual(error as? ClothingDataManagerError, .fetchFailed)
            }
        }
    }

    /// Throws fetchFailed when fetchById fails in setComment.
    func test_setComment_whenFetchByIdFails_throwsFetchFailed() async throws {
        let sut = await MainActor.run { ClothingDataManager(store: FailingClothingUserDataStore(failure: .fetchById)) }

        try await MainActor.run {
            XCTAssertThrowsError(try sut.setComment(for: 1, "Test")) { error in
                XCTAssertEqual(error as? ClothingDataManagerError, .fetchFailed)
            }
        }
    }

    // MARK: - Catch coverage: save (saveFailed)

    /// Throws saveFailed when save fails in setLiked.
    func test_setLiked_whenSaveFails_throwsSaveFailed() async throws {
        let sut = await MainActor.run { ClothingDataManager(store: FailingClothingUserDataStore(failure: .save)) }

        try await MainActor.run {
            XCTAssertThrowsError(try sut.setLiked(true, for: 1)) { error in
                XCTAssertEqual(error as? ClothingDataManagerError, .saveFailed)
            }
        }
    }

    /// Throws saveFailed when save fails in setRating.
    func test_setRating_whenSaveFails_throwsSaveFailed() async throws {
        let sut = await MainActor.run { ClothingDataManager(store: FailingClothingUserDataStore(failure: .save)) }

        try await MainActor.run {
            XCTAssertThrowsError(try sut.setRating(for: 1, 2)) { error in
                XCTAssertEqual(error as? ClothingDataManagerError, .saveFailed)
            }
        }
    }

    /// Throws saveFailed when save fails in setComment.
    func test_setComment_whenSaveFails_throwsSaveFailed() async throws {
        let sut = await MainActor.run { ClothingDataManager(store: FailingClothingUserDataStore(failure: .save)) }

        try await MainActor.run {
            XCTAssertThrowsError(try sut.setComment(for: 1, "Yo")) { error in
                XCTAssertEqual(error as? ClothingDataManagerError, .saveFailed)
            }
        }
    }
}

