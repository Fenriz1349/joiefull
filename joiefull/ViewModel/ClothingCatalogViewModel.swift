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

    private let service: ClothingServicing
    // MARK: - Init
    
    init(service: ClothingServicing = ClothingService()) {
        self.service = service
    }

    // MARK: - Catalog State

    /// Represents catalog empty states (no items or no search results).
    enum ClothingCatalogState: Equatable {
        case emptyCatalog
        case emptySearch
    }

    /// Returns current state (empty catalog or empty search).
    var state: ClothingCatalogState? {
        if clothes.isEmpty {
            return .emptyCatalog
        }

        if !searchText.isEmpty, searchResults.isEmpty {
            return .emptySearch
        }

        return nil
    }

    /// Filtered clothes list based on search text.
    var searchResults: [Clothing] {
        if searchText.isEmpty {
            return clothes
        } else {
            return clothes.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }

    /// Clears search text.
    func resetSearch() {
        searchText = ""
    }

    // MARK: - Loading

    /// Initial load (shows LoadingScreen)
    func loadIfNeeded() async {
        guard clothes.isEmpty else { return }
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
    func refreshInBackground() async {
        loadingError = nil

        do {
            clothes = try await service.fetchClothes()
        } catch let error as ClothingServiceError {
            loadingError = error
        } catch {
            loadingError = .network
        }
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
    func setClothesForPreview(_ items: [Clothing]) {
        clothes = items
        loadingError = nil
        isLoading = false
    }

    func setSearchTextForPreview(_ text: String) {
        searchText = text
    }

    func setErrorForPreview(_ error: ClothingServiceError?) {
        loadingError = error
        isLoading = false
    }
#endif
}
