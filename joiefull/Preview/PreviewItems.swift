//
//  PreviewItems.swift
//  joiefull
//
//  Created by Julien Cotte on 09/01/2026.
//

import Foundation

/// Create a local item and an array of item for preview
enum PreviewItems {
    /// Creates a sample clothing item with a given identifier
    private static func makePreviewItem(_ id: Int) -> Clothing {
        return Clothing(
        id: id,
        picture: Picture(
            url: "https://raw.githubusercontent.com/OpenClassrooms-Student-Center/Cr-ez-une-interface-dynamique-et-accessible-avec-SwiftUI/main/img/accessories/1.jpg",
            description: "Sac à main orange posé sur une poignée de porte"
        ),
        name: "Sac à main orange",
        category: .accessories,
        likes: 56,
        price: 69.99,
        originalPrice: 69.99
        )
    }

    /// Single preview item
    static var item: Clothing { makePreviewItem(0) }

    /// List of preview items with incremental identifiers
    static var itemList: [Clothing] { (0..<5).map(makePreviewItem) }
}
