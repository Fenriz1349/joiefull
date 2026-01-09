//
//  PreviewContainer.swift
//  joiefull
//
//  Created by Julien Cotte on 09/01/2026.
//

import SwiftUI
import SwiftData

/// Shared preview container providing a ready-to-use
/// `ClothingContainerViewModel` with an in-memory SwiftData stack.
enum PreviewContainer {

    /// In-memory SwiftData container for previews
    static let modelContainer: ModelContainer = {
        try! ModelContainer(
            for: ClothingUserData.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
    }()

    /// Data manager backed by the preview model context
    static let dataManager = ClothingDataManager(
        context: modelContainer.mainContext
    )

    /// Container ViewModel used across previews
    static let containerViewModel = ClothingContainerViewModel(
        dataManager: dataManager
    )
}
