//
//  EmptyListView.swift
//  joiefull
//
//  Created by Julien Cotte on 29/01/2026.
//

import SwiftUI

struct EmptyListView: View {
    let state: ClothingCatalogViewModel.ClothingCatalogState
    let onClearSearch: (() -> Void)?

    private var isSearchEmpty: Bool {
        state == .emptySearch
    }

    var body: some View {
        VStack(spacing: 12) {

            Image(systemName: isSearchEmpty ? "magnifyingglass" : "tray")
                .font(.system(size: 44, weight: .semibold))
                .accessibilityHidden(true)

            Text(isSearchEmpty ? "Aucun résultat" : "Catalogue vide")
                .font(.title3.weight(.semibold))
                .multilineTextAlignment(.center)
                .accessibilityAddTraits(.isHeader)

            Text(isSearchEmpty ? "Aucun article ne correspond à votre recherche."
                               : "Aucun article n’est disponible pour le moment."
            )
            .font(.subheadline)
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.center)

            if isSearchEmpty {
                Button("Effacer la recherche") {
                    onClearSearch?()
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 40)
        .padding(.horizontal, 24)
        // ACCESSIBILITY: one logical group
        .accessibilityElement(children: .contain)
        .accessibilityLabel(
            isSearchEmpty
            ? AccessibilityHandler.EmptyState.noResultsLabel
            : AccessibilityHandler.EmptyState.catalogEmptyLabel
        )
        .accessibilityHint(
            isSearchEmpty
            ? AccessibilityHandler.EmptyState.noResultsHint
            : AccessibilityHandler.EmptyState.catalogEmptyHint
        )
    }
}

#Preview("Liste Vide") {
    EmptyListView(state: .emptyCatalog, onClearSearch: {})
}

#Preview("Recherche vide") {
    EmptyListView(state: .emptySearch, onClearSearch: {})
}
