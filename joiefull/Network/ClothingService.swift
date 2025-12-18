//
//  ClothingService.swift
//  joiefull
//
//  Created by Julien Cotte on 12/12/2025.
//

import Foundation

final class ClothingService {
    private let url = URL(string:
        "https://raw.githubusercontent.com/OpenClassrooms-Student-Center/Cr-ez-une-interface-dynamique-et-accessible-avec-SwiftUI/main/api/clothes.json"
    )!

    func fetchClothes() async throws -> [Clothing] {
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([Clothing].self, from: data)
    }
}
