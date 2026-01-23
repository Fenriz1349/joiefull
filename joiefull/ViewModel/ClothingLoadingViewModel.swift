//
//  ClothingLoadingViewModel.swift
//  joiefull
//
//  Created by Julien Cotte on 12/12/2025.
//

import Combine
import Toasty

/// Loads clothing items from the API and exposes loading state for the UI.
@MainActor
final class ClothingLoadingViewModel: ObservableObject {
    @Published var toastyManager: ToastyManager?

    // MARK: - State

    /// Items loaded from the API.
    @Published private(set) var clothes: [Clothing] = []

    /// True while loading is in progress.
    @Published private(set) var isLoading: Bool = false

    /// Optional error message (we'll later display it via Toasty).
    @Published private(set) var errorMessage: String? = nil

    // MARK: - Dependencies

    private let service = ClothingService()
    private var hasLoaded: Bool = false

    /// Configures the toast notification manager
    /// - Parameter toastyManager: Manager for displaying toast notifications
    func configure(toastyManager: ToastyManager) {
        self.toastyManager = toastyManager
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
        defer { isLoading = false }

        do {
            clothes = try await service.fetchClothes()
        } catch {
            toastyManager?.showError(error)
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
        clothes.filter { $0.category == category }
    }
}
