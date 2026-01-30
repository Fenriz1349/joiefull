//
//  EmptyListDisplay.swift
//  joiefull
//
//  Created by Julien Cotte on 30/01/2026.
//

struct EmptyListDisplay {
    let image: String
    let title: String
    let message: String
    let accessibilityMessage: String
    let accessibilityHint: String

    static func display(_ state: ClothingCatalogViewModel.ClothingCatalogState) -> EmptyListDisplay {
        switch state {
        case .emptyCatalog:
            return EmptyListDisplay(
                image: "tray",
                title: "Catalogue vide",
                message: "Aucun article n’est disponible pour le moment.",
                accessibilityMessage: AccessibilityHandler.EmptyState.catalogEmptyLabel,
                accessibilityHint: AccessibilityHandler.EmptyState.catalogEmptyHint)
        case .emptySearch:
            return EmptyListDisplay(
                image: "magnifyingglass",
                title: "Aucun résultat",
                message: "Aucun article ne correspond à votre recherche.",
                accessibilityMessage: AccessibilityHandler.EmptyState.noResultsLabel,
                accessibilityHint: AccessibilityHandler.EmptyState.noResultsHint)
        default:
            return EmptyListDisplay(image: "", title: "", message: "", accessibilityMessage: "", accessibilityHint: "")
        }
    }
}
