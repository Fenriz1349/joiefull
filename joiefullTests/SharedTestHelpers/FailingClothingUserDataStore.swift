//
//  FailingClothingUserDataStore.swift
//  joiefullTests
//
//  Created by Julien Cotte on 06/02/2026.
//

@testable import joiefull

/// Test double that can return data or throw on demand.
final class FailingClothingUserDataStore: ClothingUserDataStore {

    /// Operation that should fail.
    enum Failure {
        case none
        case fetchAll
        case fetchById
        case save
    }

    private let failure: Failure
    private var items: [ClothingUserData]

    init(failure: Failure = .none, items: [ClothingUserData] = []) {
        self.failure = failure
        self.items = items
    }

    func fetchAll() throws -> [ClothingUserData] {
        if failure == .fetchAll { throw DummyError() }
        return items
    }

    func fetchById(_ clothingId: Int) throws -> ClothingUserData? {
        if failure == .fetchById { throw DummyError() }
        return items.first(where: { $0.clothingId == clothingId })
    }

    func insert(_ item: ClothingUserData) {
        items.append(item)
    }

    func save() throws {
        if failure == .save { throw DummyError() }
    }
}

/// Dummy error used by test doubles.
struct DummyError: Error {}

