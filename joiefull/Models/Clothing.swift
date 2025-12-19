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
        originalPrice: 69.99,
    )

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

    var descriptionText: String {
        ClothingDescriptions.byId[id] ?? ClothingDescriptions.default
    }
}
