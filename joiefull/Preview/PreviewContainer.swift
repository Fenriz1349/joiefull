//
//  PreviewContainer.swift
//  joiefull
//
//  Created by Julien Cotte on 09/01/2026.
//

import SwiftUI
import SwiftData
import Toasty

/// Shared preview container providing a ready-to-use
/// `ClothingContainerViewModel` with an in-memory SwiftData stack.
enum PreviewContainer {

    /// In-memory SwiftData container for previews
    static let modelContainer: ModelContainer = {
        do {
            return try ModelContainer(for: ClothingUserData.self,
                                      configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        } catch {
            fatalError("Failed to initialize SwiftData ModelContainer: \(error)")
        }
    }()

    /// Data manager backed by the preview model context
    static let dataManager = ClothingDataManager(
        context: modelContainer.mainContext
    )

    /// Container ViewModel used across previews
    static let containerViewModel = ClothingContainerViewModel(
        dataManager: dataManager
    )

    /// Loader ViewModel used across previews
    static let loadingViewModel = ClothingLoadingViewModel()

    /// Toasty Manager used across previews
    static var sampleToastyManager: ToastyManager {
        ToastyManager()
    }
}
