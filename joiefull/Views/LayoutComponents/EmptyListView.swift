//
//  EmptyListView.swift
//  joiefull
//
//  Created by Julien Cotte on 29/01/2026.
//

import SwiftUI

struct EmptyListView: View {
    
    let state: ClothingCatalogViewModel.ClothingCatalogState
    let searchReset: () -> Void
    let catalogReset: () -> Void
    
    var display: EmptyListDisplay {
        EmptyListDisplay.display(for: state)
    }
    
    var body: some View {
        if state == .emptyCatalog {
            BrandingContentView {
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
                    
                    Button("Recharger") {
                        catalogReset()
                    }
                }
                .padding(.vertical, 40)
                .padding(.horizontal, 24)
                // ACCESSIBILITY
                .accessibilityElement(children: .contain)
                .accessibilityLabel(display.accessibilityMessage)
                .accessibilityHint(display.accessibilityHint)
            }
        } else {
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
                
                Button("Effacer la recherche") {
                    searchReset()
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
}

#Preview("Empty Catalog") {
    EmptyListView(state: .emptyCatalog, searchReset: {}, catalogReset: {})
        .environmentObject(PreviewContainer.emptyCatalogViewModel())
}

#Preview("Empty Search") {
    EmptyListView(state: .emptySearch, searchReset: {}, catalogReset: {})
        .environmentObject(PreviewContainer.emptySearchViewModel())
}

