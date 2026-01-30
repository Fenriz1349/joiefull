//
//  JoiefullApp.swift
//  joiefull
//
//  Created by Julien Cotte on 12/12/2025.
//

import SwiftUI
import SwiftData
import Toasty

/// Main app entry point for the Joiefull application
/// Configures SwiftData persistence and initializes the view model hierarchy
/// Create and inject viewModels and ToasterManager
@main
struct JoiefullApp: App {

    let modelContainer: ModelContainer
    let containerViewModel: ClothingContainerViewModel
    let clothingLoadingViewModel: ClothingCatalogViewModel
    @StateObject private var toasty = ToastyManager()

    init() {
        do {
            let container = try ModelContainer(for: ClothingUserData.self)
            let dataManager = ClothingDataManager(context: container.mainContext)

            self.modelContainer = container
            self.containerViewModel = ClothingContainerViewModel(dataManager: dataManager)
            self.clothingLoadingViewModel = ClothingCatalogViewModel()
        } catch {
            fatalError("Failed to initialize SwiftData ModelContainer: \(error)")
        }
    }

    var body: some Scene {
        WindowGroup {
            ToastyContainer(manager: toasty) {
                AppEntryView()
                    .environmentObject(containerViewModel)
                    .environmentObject(clothingLoadingViewModel)
            }
            .environmentObject(toasty)
        }
        .modelContainer(modelContainer)
    }
}
