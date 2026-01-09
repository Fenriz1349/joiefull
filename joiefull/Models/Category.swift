//
//  Category.swift
//  joiefull
//
//  Created by Julien Cotte on 19/12/2025.
//

/// Represents the different categories of clothing items available in the app
enum Category: String, Decodable, CaseIterable, Hashable {
    case tops = "TOPS"
    case bottoms = "BOTTOMS"
    case shoes = "SHOES"
    case accessories = "ACCESSORIES"

    /// Returns the localized display title for the category
    var title: String {
        switch self {
        case .tops: return "Hauts"
        case .bottoms: return "Bas"
        case .shoes: return "Chaussures"
        case .accessories: return "Sacs & Accessoires"
        }
    }
}
