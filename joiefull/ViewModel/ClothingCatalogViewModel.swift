//
//  ClothingCatalogViewModel.swift
//  joiefull
//
//  Created by Julien Cotte on 12/12/2025.
//

import Foundation
import Combine

/// Loads clothing items from the API and exposes loading state for the UI.
@MainActor
final class ClothingCatalogViewModel: ObservableObject {

    // MARK: - State

    /// Items loaded from the API and filtrated cloathes list
    @Published private(set) var clothes: [Clothing] = []
    @Published var searchText = ""

    /// True while loading is in progress.
    @Published private(set) var isLoading: Bool = false

    /// Loading error handling
    @Published private(set) var loadingError: ClothingServiceError?

    // MARK: - Dependencies

    private let service = ClothingService()
    private var hasLoaded: Bool = false

    // MARK: - Catalog State

    enum ClothingCatalogState: Equatable {
        case emptyCatalog
        case emptySearch
        case content
    }

    var state: ClothingCatalogState {
        if clothes.isEmpty {
            return .emptyCatalog
        }

        if !searchText.isEmpty, searchResults.isEmpty {
            return .emptySearch
        }

        return .content
    }

    var searchResults: [Clothing] {
        if searchText.isEmpty {
            return clothes
        } else {
            return clothes.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }

    func resetSearch() {
        searchText = ""
    }

    // MARK: - Loading

    /// Loads data once. Subsequent calls are ignored unless you reset.
    func loadIfNeeded() async {
        guard !hasLoaded else { return }
        hasLoaded = true
        await load()
    }

    /// Reloads data from the API.
    func load() async {
        isLoading = true
        loadingError = nil
        defer { isLoading = false }

        do {
            clothes = try await service.fetchClothes()
        } catch let error as ClothingServiceError {
            loadingError = error
        } catch {
            loadingError = .network
        }
    }

    /// Allows forcing a reload (e.g. pull-to-refresh).
    func resetAndReload() async {
        hasLoaded = false
        await loadIfNeeded()
    }

    // MARK: - Helpers

    /// Filters items by category.
    /// - Parameter category: Category to filter by.
    func clothes(for category: Category) -> [Clothing] {
        let base = clothes.filter { $0.category == category }

        guard !searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return base
        }

        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        return base.filter { $0.name.localizedCaseInsensitiveContains(query) }
    }
}
extension ClothingCatalogViewModel {

#if DEBUG
    func setErrorForPreview(_ error: ClothingServiceError) {
        loadingError = error
    }
#endif
}
