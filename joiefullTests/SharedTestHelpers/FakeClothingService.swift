//
//  FakeClothingService.swift
//  joiefullTests
//
//  Created by Julien Cotte on 06/02/2026.
//

@testable import joiefull

/// Fake service used to control success/failure paths deterministically.
final class FakeClothingService: ClothingServicing {

    enum Mode {
        case success([Clothing])
        case failure(Error)
    }

    private let mode: Mode
    private(set) var fetchCallCount = 0

    init(mode: Mode) {
        self.mode = mode
    }

    func fetchClothes() async throws -> [Clothing] {
        fetchCallCount += 1
        switch mode {
        case .success(let items):
            return items
        case .failure(let error):
            throw error
        }
    }
}

/// Dummy error used to simulate unknown failures.
struct DummyServiceError: Error {}
