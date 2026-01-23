//
//  ClothingService.swift
//  joiefull
//
//  Created by Julien Cotte on 12/12/2025.
//

import Foundation

/// Handles network requests to fetch clothing data from the remote API
final class ClothingService {

    private let url = URL(string:
        "https://raw.githubusercontent.com/OpenClassrooms-Student-Center/Cr-ez-une-interface-dynamique-et-accessible-avec-SwiftUI/main/api/clothes.json"
    )!

    /// Fetches all clothing items from the remote API
    /// - Returns: Decoded list of items
    /// - Throws: ClothingServiceError
    func fetchClothes() async throws -> [Clothing] {
        do {
            let (data, response) = try await URLSession.shared.data(from: url)

            guard let http = response as? HTTPURLResponse else {
                throw ClothingServiceError.invalidResponse
            }
            guard (200..<300).contains(http.statusCode) else {
                throw ClothingServiceError.httpStatus(http.statusCode)
            }

            do {
                return try JSONDecoder().decode([Clothing].self, from: data)
            } catch {
                throw ClothingServiceError.decoding
            }

        } catch is URLError {
            throw ClothingServiceError.network
        } catch let error as ClothingServiceError {
            throw error
        } catch {
            throw ClothingServiceError.network
        }
    }
}
