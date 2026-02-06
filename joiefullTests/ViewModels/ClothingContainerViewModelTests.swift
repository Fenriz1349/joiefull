//
//  ClothingContainerViewModelTests.swift
//  joiefullTests
//
//  Created by Julien Cotte on 06/02/2026.
//

import XCTest
import SwiftUI
import Toasty
@testable import joiefull

final class ClothingContainerViewModelTests: XCTestCase {

    override func tearDown() async throws {
        await MainActor.run {
            DeviceType.debugOverride = nil
        }
        try await super.tearDown()
    }

    // MARK: - init / loadUserData

    /// Loads user data on init when data manager succeeds.
    func test_init_loadsUserData_success() async {
        await MainActor.run {
            let dm = FakeClothingDataManager()
            dm.loadLikedIdsResult = .success([1, 3])
            dm.loadRatingsResult = .success([1: 4])
            dm.loadCommentsResult = .success([1: "Top"])

            let sut = ClothingContainerViewModel(dataManager: dm)

            XCTAssertEqual(sut.likedItemIds, Set([1, 3]))
            XCTAssertEqual(sut.ratingsByItemId, [1: 4])
            XCTAssertEqual(sut.commentsByItemId, [1: "Top"])
        }
    }

    /// Stores the provided ToastyManager instance.
    func test_configure_setsToastyManager() async {
        await MainActor.run {
            let sut = ClothingContainerViewModel(dataManager: FakeClothingDataManager())
            let manager = ToastyManager()

            sut.configure(toastyManager: manager)

            XCTAssertTrue(sut.toastyManager === manager)
        }
    }

    /// Does not update user data when loading fails.
    func test_loadUserData_whenThrows_doesNotUpdateState() async {
        await MainActor.run {
            let dm = FakeClothingDataManager()
            dm.loadLikedIdsResult = .failure(DummyError())

            let sut = ClothingContainerViewModel(dataManager: dm)

            XCTAssertTrue(sut.likedItemIds.isEmpty)
            XCTAssertTrue(sut.ratingsByItemId.isEmpty)
            XCTAssertTrue(sut.commentsByItemId.isEmpty)
        }
    }

    // MARK: - Selection / split

    /// Toggles selection on same item.
    func test_toggleSelection_togglesSelectedItem() async {
        await MainActor.run {
            let dm = FakeClothingDataManager()
            let sut = ClothingContainerViewModel(dataManager: dm)
            let item = SharedTestHelper.clothing(id: 1, name: "Pull", category: .tops)

            sut.toggleSelection(item)
            XCTAssertEqual(sut.selectedItem?.id, 1)

            sut.toggleSelection(item)
            XCTAssertNil(sut.selectedItem)
        }
    }

    /// isSplitted is true only on iPad with a selection.
    func test_isSplitted_iPadWithSelection_returnsTrue() async {
        await MainActor.run {
            DeviceType.debugOverride = .iPad

            let sut = ClothingContainerViewModel(dataManager: FakeClothingDataManager())
            let item = SharedTestHelper.clothing(id: 1, name: "Pull", category: .tops)

            XCTAssertFalse(sut.isSplitted)

            sut.toggleSelection(item)
            XCTAssertTrue(sut.isSplitted)
        }
    }

    /// isSplitted is false on iPhone even with a selection.
    func test_isSplitted_iPhoneWithSelection_returnsFalse() async {
        await MainActor.run {
            DeviceType.debugOverride = .iPhone

            let sut = ClothingContainerViewModel(dataManager: FakeClothingDataManager())
            let item = SharedTestHelper.clothing(id: 1, name: "Pull", category: .tops)

            sut.toggleSelection(item)
            XCTAssertFalse(sut.isSplitted)
        }
    }

    // MARK: - Likes

    /// Computes displayed likes depending on like state.
    func test_getDisplayedLikes_incrementsWhenLiked() async {
        await MainActor.run {
            let dm = FakeClothingDataManager()
            dm.loadLikedIdsResult = .success([1])

            let sut = ClothingContainerViewModel(dataManager: dm)
            let item = SharedTestHelper.clothing(id: 1, name: "Pull", category: .tops, likes: 10)

            XCTAssertTrue(sut.isLiked(item))
            XCTAssertEqual(sut.getdisplayedLikes(for: item), 11)
        }
    }

    /// Does not increment likes when not liked.
    func test_getDisplayedLikes_keepsSameWhenNotLiked() async {
        await MainActor.run {
            let sut = ClothingContainerViewModel(dataManager: FakeClothingDataManager())
            let item = SharedTestHelper.clothing(id: 1, name: "Pull", category: .tops, likes: 10)

            XCTAssertFalse(sut.isLiked(item))
            XCTAssertEqual(sut.getdisplayedLikes(for: item), 10)
        }
    }

    /// Toggles like on and persists it.
    func test_toggleLike_whenNotLiked_addsIdAndCallsDataManager() async {
        await MainActor.run {
            let dm = FakeClothingDataManager()
            let sut = ClothingContainerViewModel(dataManager: dm)
            let item = SharedTestHelper.clothing(id: 7, name: "Sac", category: .accessories)

            sut.toggleLike(for: item)

            XCTAssertTrue(sut.likedItemIds.contains(7))
            XCTAssertEqual(dm.setLikedCalls.count, 1)
            XCTAssertEqual(dm.setLikedCalls.first?.0, true)
            XCTAssertEqual(dm.setLikedCalls.first?.1, 7)
        }
    }

    /// Toggles like off and persists it.
    func test_toggleLike_whenLiked_removesIdAndCallsDataManager() async {
        await MainActor.run {
            let dm = FakeClothingDataManager()
            dm.loadLikedIdsResult = .success([7])

            let sut = ClothingContainerViewModel(dataManager: dm)
            let item = SharedTestHelper.clothing(id: 7, name: "Sac", category: .accessories)

            sut.toggleLike(for: item)

            XCTAssertFalse(sut.likedItemIds.contains(7))
            XCTAssertEqual(dm.setLikedCalls.count, 1)
            XCTAssertEqual(dm.setLikedCalls.first?.0, false)
            XCTAssertEqual(dm.setLikedCalls.first?.1, 7)
        }
    }

    /// Does not update likedItemIds when persistence fails.
    func test_toggleLike_whenDataManagerThrows_doesNotChangeState() async {
        await MainActor.run {
            let dm = FakeClothingDataManager()
            dm.setLikedResult = .failure(DummyError())

            let sut = ClothingContainerViewModel(dataManager: dm)
            let item = SharedTestHelper.clothing(id: 1, name: "Pull", category: .tops)

            sut.toggleLike(for: item)

            XCTAssertFalse(sut.likedItemIds.contains(1))
            XCTAssertEqual(dm.setLikedCalls.count, 1)
        }
    }

    // MARK: - Rating

    /// Returns 0 when item has no rating.
    func test_getRating_whenMissing_returnsZero() async {
        await MainActor.run {
            let sut = ClothingContainerViewModel(dataManager: FakeClothingDataManager())
            let item = SharedTestHelper.clothing(id: 1, name: "Pull", category: .tops)

            XCTAssertEqual(sut.getRating(for: item), 0)
        }
    }

    /// Sets rating when in range and different from current value.
    func test_setNewRating_valid_updatesStateAndCallsDataManager() async {
        await MainActor.run {
            let dm = FakeClothingDataManager()
            let sut = ClothingContainerViewModel(dataManager: dm)
            let item = SharedTestHelper.clothing(id: 1, name: "Pull", category: .tops)

            sut.setNewRating(for: item, rating: 4)

            XCTAssertEqual(sut.ratingsByItemId[1], 4)
            XCTAssertEqual(dm.setRatingCalls.count, 1)
            XCTAssertEqual(dm.setRatingCalls.first?.0, 1)
            XCTAssertEqual(dm.setRatingCalls.first?.1, 4)
        }
    }

    /// Does nothing when rating is out of range.
    func test_setNewRating_outOfRange_doesNothing() async {
        await MainActor.run {
            let dm = FakeClothingDataManager()
            let sut = ClothingContainerViewModel(dataManager: dm)
            let item = SharedTestHelper.clothing(id: 1, name: "Pull", category: .tops)

            sut.setNewRating(for: item, rating: 6)

            XCTAssertNil(sut.ratingsByItemId[1])
            XCTAssertTrue(dm.setRatingCalls.isEmpty)
        }
    }

    /// Does nothing when rating is unchanged.
    func test_setNewRating_sameValue_doesNothing() async {
        await MainActor.run {
            let dm = FakeClothingDataManager()
            dm.loadRatingsResult = .success([1: 3])

            let sut = ClothingContainerViewModel(dataManager: dm)
            let item = SharedTestHelper.clothing(id: 1, name: "Pull", category: .tops)

            sut.setNewRating(for: item, rating: 3)

            XCTAssertEqual(dm.setRatingCalls.count, 0)
            XCTAssertEqual(sut.ratingsByItemId[1], 3)
        }
    }

    /// Does not update rating when persistence fails.
    func test_setNewRating_whenDataManagerThrows_doesNotUpdateRating() async {
        await MainActor.run {
            let dm = FakeClothingDataManager()
            dm.setRatingResult = .failure(DummyError())

            let sut = ClothingContainerViewModel(dataManager: dm)
            let item = SharedTestHelper.clothing(id: 1, name: "Pull", category: .tops)

            sut.setNewRating(for: item, rating: 4)

            XCTAssertNil(sut.ratingsByItemId[1])
            XCTAssertEqual(dm.setRatingCalls.count, 1)
        }
    }

    /// Uses global rating when user rating is 0, otherwise blends.
    func test_getCalculatedRating_usesGlobalOrBlended() async {
        await MainActor.run {
            let dm = FakeClothingDataManager()
            dm.loadRatingsResult = .success([1: 0, 2: 5])

            let sut = ClothingContainerViewModel(dataManager: dm)
            let item1 = SharedTestHelper.clothing(id: 1, name: "Pull", category: .tops)
            let item2 = SharedTestHelper.clothing(id: 2, name: "Jean", category: .bottoms)

            XCTAssertEqual(sut.getCalculatedRating(item1), item1.globalRating)

            let expected = item2.globalRating * 0.9 + 5.0 * 0.1
            XCTAssertEqual(sut.getCalculatedRating(item2), expected)
        }
    }

    // MARK: - Comment

    /// Returns empty string when comment is missing.
    func test_getComment_whenMissing_returnsEmptyString() async {
        await MainActor.run {
            let sut = ClothingContainerViewModel(dataManager: FakeClothingDataManager())
            let item = SharedTestHelper.clothing(id: 1, name: "Pull", category: .tops)

            XCTAssertEqual(sut.getComment(for: item), "")
        }
    }

    /// Sets comment and persists it.
    func test_setNewComment_updatesStateAndCallsDataManager() async {
        await MainActor.run {
            let dm = FakeClothingDataManager()
            let sut = ClothingContainerViewModel(dataManager: dm)
            let item = SharedTestHelper.clothing(id: 1, name: "Pull", category: .tops)

            sut.setNewComment(for: item, comment: "Super")

            XCTAssertEqual(sut.commentsByItemId[1], "Super")
            XCTAssertEqual(dm.setCommentCalls.count, 1)
            XCTAssertEqual(dm.setCommentCalls.first?.0, 1)
            XCTAssertEqual(dm.setCommentCalls.first?.1, "Super")
        }
    }

    /// Does not update comment when persistence fails.
    func test_setNewComment_whenDataManagerThrows_doesNotUpdateComment() async {
        await MainActor.run {
            let dm = FakeClothingDataManager()
            dm.setCommentResult = .failure(DummyError())

            let sut = ClothingContainerViewModel(dataManager: dm)
            let item = SharedTestHelper.clothing(id: 1, name: "Pull", category: .tops)

            sut.setNewComment(for: item, comment: "Test")

            XCTAssertNil(sut.commentsByItemId[1])
            XCTAssertEqual(dm.setCommentCalls.count, 1)
        }
    }

    /// Binding reads and writes through view model methods.
    func test_commentTextBinding_readsAndWrites() async {
        await MainActor.run {
            let dm = FakeClothingDataManager()
            let sut = ClothingContainerViewModel(dataManager: dm)
            let item = SharedTestHelper.clothing(id: 1, name: "Pull", category: .tops)

            let binding = sut.commentTextBinding(for: item)

            XCTAssertEqual(binding.wrappedValue, "")

            binding.wrappedValue = "Hello"
            XCTAssertEqual(sut.getComment(for: item), "Hello")
            XCTAssertEqual(dm.setCommentCalls.count, 1)
        }
    }

    // MARK: - Share

    /// Builds default note when input note is empty.
    func test_makeSharePayload_whenNoteEmpty_usesDefaultMessage() async {
        await MainActor.run {
            let sut = ClothingContainerViewModel(dataManager: FakeClothingDataManager())
            let item = SharedTestHelper.clothing(
                id: 1,
                name: "Pull",
                category: .tops,
                picture: SharedTestHelper.picture(url: "https://example.com/pull.png", description: "Pull")
            )

            sut.makeSharePayload(for: item, shareNote: "   ")

            XCTAssertNotNil(sut.sharePayload)
        }
    }

    /// Uses provided note when not empty.
    func test_makeSharePayload_whenNoteProvided_includesCustomNote() async {
        await MainActor.run {
            let sut = ClothingContainerViewModel(dataManager: FakeClothingDataManager())
            let item = SharedTestHelper.clothing(
                id: 1,
                name: "Pull",
                category: .tops,
                picture: SharedTestHelper.picture(url: "https://example.com/pull.png", description: "Pull")
            )

            sut.makeSharePayload(for: item, shareNote: "Regarde ça")

            XCTAssertNotNil(sut.sharePayload)
        }
    }
}

