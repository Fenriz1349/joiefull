//
//  ClothingContainerViewModel.swift
//  joiefull
//
//  Created by Julien Cotte on 19/12/2025.
//

import Combine

@MainActor
final class ClothingContainerViewModel: ObservableObject {

    @Published var selectedItem: Clothing?

    func toggleSelection(_ item: Clothing) {
        if selectedItem?.id == item.id {
            selectedItem = nil
        } else {
            selectedItem = item
        }
    }
}
