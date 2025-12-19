//
//  Category.swift
//  joiefull
//
//  Created by Julien Cotte on 19/12/2025.
//

enum Category: String, Decodable, CaseIterable, Hashable {
    case tops = "TOPS"
    case bottoms = "BOTTOMS"
    case shoes = "SHOES"
    case accessories = "ACCESSORIES"

    var title: String {
        switch self {
        case .tops: return "Hauts"
        case .bottoms: return "Bas"
        case .shoes: return "Chaussures"
        case .accessories: return "Sacs & Accessoires"
        }
    }
}
