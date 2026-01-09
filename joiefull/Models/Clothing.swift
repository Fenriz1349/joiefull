//
//  Clothing.swift
//  joiefull
//
//  Created by Julien Cotte on 12/12/2025.
//

/// Represents a clothing item with all its properties
/// Conforms to Identifiable for use in SwiftUI lists and Decodable for API parsing
struct Clothing: Identifiable, Decodable, Hashable {
    let id: Int
    let picture: Picture
    let name: String
    let category: Category
    let likes: Int
    let price: Double
    let originalPrice: Double

    enum CodingKeys: String, CodingKey {
        case id, picture, name, category, likes, price
        case originalPrice = "original_price"
    }
}

extension Clothing {
    /// Returns the global rating for this clothing item (0.0 to 5.0 scale)
    /// Hardcoded ratings based on item ID for demo purposes
    var globalRating: Double {
        switch id {
        case 0:  3.9
        case 1:  4.2
        case 2:  4.5
        case 3:  4.1
        case 4:  4.6
        case 5:  4.8
        case 6:  0.0
        case 7:  4.3
        case 8:  4.9
        case 9:  4.0
        case 10: 4.7
        case 11: 4.4
        default:  4.1
        }
    }

    /// Returns the detailed description text for this clothing item
    /// Falls back to a default description if no specific description exists
    var descriptionText: String {
        ClothingDescriptions.byId[id] ?? ClothingDescriptions.default
    }
}
