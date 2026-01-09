//
//  JoiefullApp.swift
//  joiefull
//
//  Created by Julien Cotte on 12/12/2025.
//

import SwiftUI
import SwiftData

/// Main app entry point for the Joiefull application
/// Configures SwiftData persistence and initializes the view model hierarchy
@main
struct JoiefullApp: App {

    let modelContainer: ModelContainer
    let containerViewModel: ClothingContainerViewModel

    init() {
        do {
            let container = try ModelContainer(for: ClothingUserData.self)
            let dataManager = ClothingDataManager(context: container.mainContext)

            self.modelContainer = container
            self.containerViewModel = ClothingContainerViewModel(dataManager: dataManager)
        } catch {
            fatalError("Failed to initialize SwiftData ModelContainer: \(error)")
        }
    }

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(containerViewModel)
        }
        .modelContainer(modelContainer)
    }
}
