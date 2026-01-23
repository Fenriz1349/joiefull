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

    /// Fetches all clothing items from the remote API detached from mainthread
    /// - Returns: An array of decoded Clothing objects
    /// - Throws: Network errors or JSON decoding errors
    func fetchClothes() async throws -> [Clothing] {
        let (data, response) = try await URLSession.shared.data(from: url)

        if let http = response as? HTTPURLResponse, !(200...299).contains(http.statusCode) {
            throw URLError(.badServerResponse)
        }

        return try await Task.detached(priority: .userInitiated) {
            try JSONDecoder().decode([Clothing].self, from: data)
        }.value
    }
}
