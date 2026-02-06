//
//  ClothingCatalogViewModelTests.swift
//  joiefullTests
//
//  Created by Julien Cotte on 06/02/2026.
//

import XCTest
@testable import joiefull

@MainActor
final class ClothingCatalogViewModelTests: XCTestCase {

    // MARK: - searchResults / state

    /// Returns emptyCatalog when no clothes are loaded.
    func test_state_whenClothesEmpty_returnsEmptyCatalog() async {
        await MainActor.run {
            let sut = ClothingCatalogViewModel(service: FakeClothingService(mode: .success([])))
            
            XCTAssertEqual(sut.state, .emptyCatalog)
        }
    }

    /// Returns all clothes when search text is empty.
    func test_searchResults_whenSearchEmpty_returnsAllClothes() async {
        await MainActor.run {
            let items = SharedTestHelper.sampleClothes()
            let sut = ClothingCatalogViewModel(service: FakeClothingService(mode: .success(items)))
            
            sut.setClothesForPreview(items)
            sut.searchText = ""
            
            XCTAssertEqual(sut.searchResults, items)
            XCTAssertNil(sut.state)
        }
    }

    /// Filters results by name using case-insensitive match.
    func test_searchResults_whenSearchNotEmpty_filtersByName() async {
        await MainActor.run {
            let items = SharedTestHelper.sampleClothes()
            let sut = ClothingCatalogViewModel(service: FakeClothingService(mode: .success(items)))
            
            sut.setClothesForPreview(items)
            sut.searchText = "pUlL"
            
            XCTAssertEqual(sut.searchResults.map(\.name), ["Pull"])
        }
    }

    /// Returns emptySearch when search has no results.
    func test_state_whenSearchHasNoResults_returnsEmptySearch() async {
        await MainActor.run {
            let items = SharedTestHelper.sampleClothes()
            let sut = ClothingCatalogViewModel(service: FakeClothingService(mode: .success(items)))
            
            sut.setClothesForPreview(items)
            sut.searchText = "zzzz"
            
            XCTAssertEqual(sut.state, .emptySearch)
        }
    }

    /// Clears the search text.
    func test_resetSearch_clearsSearchText() async {
        await MainActor.run {
            let sut = ClothingCatalogViewModel(service: FakeClothingService(mode: .success([])))
            sut.searchText = "abc"
            
            sut.resetSearch()
            
            XCTAssertEqual(sut.searchText, "")
        }
    }

    // MARK: - clothes(for:)

    /// Filters clothes by category when search is empty/whitespace.
    func test_clothesForCategory_whenSearchIsWhitespace_filtersOnlyByCategory() async {
        await MainActor.run {
            let items = SharedTestHelper.sampleClothes()
            let sut = ClothingCatalogViewModel(service: FakeClothingService(mode: .success(items)))
            
            sut.setClothesForPreview(items)
            sut.searchText = "   "
            
            let result = sut.clothes(for: .tops)
            XCTAssertEqual(result.map(\.name), ["Pull"])
        }
    }

    /// Filters clothes by category and trimmed search query.
    func test_clothesForCategory_whenSearchHasText_filtersByCategoryAndName() async {
        await MainActor.run {
            let items = SharedTestHelper.sampleClothes()
            let sut = ClothingCatalogViewModel(service: FakeClothingService(mode: .success(items)))
            
            sut.setClothesForPreview(items)
            sut.searchText = "  chaussures  "
            
            let result = sut.clothes(for: .shoes)
            XCTAssertEqual(result.map(\.name), ["Chaussures de sport"])
        }
    }

    // MARK: - loadIfNeeded

    /// Does not call service when clothes are already loaded.
    func test_loadIfNeeded_whenAlreadyLoaded_doesNotFetchAgain() async {
        let items = SharedTestHelper.sampleClothes()
        let fake = FakeClothingService(mode: .success(items))
        let sut = ClothingCatalogViewModel(service: fake)

        sut.setClothesForPreview(items)

        await sut.loadIfNeeded()

        XCTAssertEqual(fake.fetchCallCount, 0)
    }

    /// Loads clothes on first call and clears errors.
    func test_loadIfNeeded_success_setsClothesAndClearsError() async {
        let items = SharedTestHelper.sampleClothes()
        let fake = FakeClothingService(mode: .success(items))
        let sut = ClothingCatalogViewModel(service: fake)

        await sut.loadIfNeeded()

        XCTAssertEqual(fake.fetchCallCount, 1)
        XCTAssertEqual(sut.clothes, items)
        XCTAssertNil(sut.loadingError)
        XCTAssertFalse(sut.isLoading)
    }

    /// Maps a ClothingServiceError to loadingError.
    func test_loadIfNeeded_whenServiceThrowsServiceError_setsLoadingError() async {
        // Remplace si ton enum n’a pas .network
        let serviceError = ClothingServiceError.network
        let fake = FakeClothingService(mode: .failure(serviceError))
        let sut = ClothingCatalogViewModel(service: fake)

        await sut.loadIfNeeded()

        XCTAssertEqual(sut.loadingError, serviceError)
        XCTAssertFalse(sut.isLoading)
    }

    /// Maps unknown errors to .network.
    func test_loadIfNeeded_whenServiceThrowsUnknown_setsNetworkError() async {
        let fake = FakeClothingService(mode: .failure(DummyServiceError()))
        let sut = ClothingCatalogViewModel(service: fake)

        await sut.loadIfNeeded()

        XCTAssertEqual(sut.loadingError, .network)
        XCTAssertFalse(sut.isLoading)
    }

    // MARK: - refreshInBackground

    /// Refreshes clothes and clears errors on success.
    func test_refreshInBackground_success_updatesClothesAndClearsError() async {
        let items = SharedTestHelper.sampleClothes()
        let fake = FakeClothingService(mode: .success(items))
        let sut = ClothingCatalogViewModel(service: fake)

        sut.setErrorForPreview(.network)

        await sut.refreshInBackground()

        XCTAssertEqual(fake.fetchCallCount, 1)
        XCTAssertEqual(sut.clothes, items)
        XCTAssertNil(sut.loadingError)
    }

    /// Sets loadingError when refresh fails with ClothingServiceError.
    func test_refreshInBackground_whenServiceThrowsServiceError_setsLoadingError() async {
        let serviceError = ClothingServiceError.network
        let fake = FakeClothingService(mode: .failure(serviceError))
        let sut = ClothingCatalogViewModel(service: fake)

        await sut.refreshInBackground()

        XCTAssertEqual(sut.loadingError, serviceError)
    }

    /// Maps unknown refresh errors to .network.
    func test_refreshInBackground_whenServiceThrowsUnknown_setsNetworkError() async {
        let fake = FakeClothingService(mode: .failure(DummyServiceError()))
        let sut = ClothingCatalogViewModel(service: fake)

        await sut.refreshInBackground()

        XCTAssertEqual(sut.loadingError, .network)
    }
}

