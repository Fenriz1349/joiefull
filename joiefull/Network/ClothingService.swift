//
//  ClothingService.swift
//  joiefull
//
//  Created by Julien Cotte on 12/12/2025.
//

import Foundation

/// Handles network requests to fetch clothing data from the remote API
final class ClothingService {

    /// URL endpoint for the clothing items JSON data
    private let url = URL(string:
        "https://raw.githubusercontent.com/OpenClassrooms-Student-Center/Cr-ez-une-interface-dynamique-et-accessible-avec-SwiftUI/main/api/clothes.json"
    )!

    /// Fetches all clothing items from the remote API
    /// - Returns: An array of decoded Clothing objects
    /// - Throws: Network errors or JSON decoding errors
    func fetchClothes() async throws -> [Clothing] {
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([Clothing].self, from: data)
    }
}
