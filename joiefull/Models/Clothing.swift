//
//  Clothing.swift
//  joiefull
//
//  Created by Julien Cotte on 12/12/2025.
//

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

extension Clothing {
    static let preview = Clothing(
        id: 0,
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

    static let previewList: [Clothing] = [
        Clothing(
            id: 1,
            picture: Picture(
                url: "https://via.placeholder.com/300",
                description: "Pull vert"
            ),
            name: "Pull vert",
            category: .tops,
            likes: 12,
            price: 29.99,
            originalPrice: 39.99
        ),
        Clothing(
            id: 2,
            picture: Picture(
                url: "https://via.placeholder.com/300",
                description: "Sac à dos"
            ),
            name: "Sac à dos",
            category: .accessories,
            likes: 9,
            price: 69.99,
            originalPrice: 99.99
        )
    ]
}
