//
//  EmptyListView.swift
//  joiefull
//
//  Created by Julien Cotte on 29/01/2026.
//

import SwiftUI

struct EmptyListView: View {
    @EnvironmentObject private var catalog: ClothingCatalogViewModel

    private var display: EmptyListDisplay {
        EmptyListDisplay.display(catalog.state)
    }

    var body: some View {
        VStack(spacing: 12) {

            Image(systemName: display.image)
                .font(.system(size: 44, weight: .semibold))
                .accessibilityHidden(true)

            Text(display.title)
                .font(.title3.weight(.semibold))
                .multilineTextAlignment(.center)
                .accessibilityAddTraits(.isHeader)

            Text(display.message)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)

            switch catalog.state {
            case .emptySearch:
                Button("Effacer la recherche") {
                    catalog.resetSearch()
                }
            case .emptyCatalog:
                Button("Recharger") {
                    Task { await catalog.resetAndReload() }
                }
            default: EmptyView()
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 40)
        .padding(.horizontal, 24)
        // ACCESSIBILITY
        .accessibilityElement(children: .contain)
        .accessibilityLabel(display.accessibilityMessage)
        .accessibilityHint(display.accessibilityHint)
    }
}

#Preview("Liste Vide") {
    EmptyListView()
        .environmentObject(PreviewContainer.emptyCatalogViewModel())
}

#Preview("Recherche vide") {
    EmptyListView()
        .environmentObject(PreviewContainer.emptySearchViewModel())
}
