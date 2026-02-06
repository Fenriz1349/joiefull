//
//  ClothingService.swift
//  joiefull
//
//  Created by Julien Cotte on 12/12/2025.
//

import Foundation

protocol ClothingServicing {
    func fetchClothes() async throws -> [Clothing]
}

/// Handles network requests to fetch clothing data from the remote API
final class ClothingService: ClothingServicing {
    
    private let url: URL?
    private let session: URLSession

    init(
        url: URL? = URL(string: "https://raw.githubusercontent.com/OpenClassrooms-Student-Center/Cr-ez-une-interface-dynamique-et-accessible-avec-SwiftUI/main/api/clothes.json"),
        session: URLSession = .shared
    ) {
        self.url = url
        self.session = session
    }

    /// Fetches all clothing items from the remote API.
    /// - Returns: Decoded list of items.
    /// - Throws: `ClothingServiceError`.
    func fetchClothes() async throws -> [Clothing] {
        let (data, response) = try await fetchData()
        try validate(response: response)
        return try decodeClothes(from: data)
    }

    /// Fetches raw JSON data from the API.
    /// - Returns: Raw data and response.
    /// - Throws: `ClothingServiceError.network` if request fails.
    private func fetchData() async throws -> (Data, URLResponse) {
        guard let url else { throw  ClothingServiceError.invalidURL }
        var request = URLRequest(url: url)
        request.timeoutInterval = 8

        do {
            return try await session.data(for: request)
        } catch {
            throw ClothingServiceError.network
        }
    }

    /// Validates HTTP response status.
    /// - Parameter response: URL response.
    /// - Throws: `ClothingServiceError` if invalid or non-2xx.
    private func validate(response: URLResponse) throws {
        guard let http = response as? HTTPURLResponse else {
            throw ClothingServiceError.invalidResponse
        }
        guard (200..<300).contains(http.statusCode) else {
            throw ClothingServiceError.httpStatus(http.statusCode)
        }
    }

    /// Decodes clothes JSON payload.
    /// - Parameter data: Raw JSON data.
    /// - Returns: Decoded clothes list.
    /// - Throws: `ClothingServiceError.decoding` if decoding fails.
    private func decodeClothes(from data: Data) throws -> [Clothing] {
        do {
            return try JSONDecoder().decode([Clothing].self, from: data)
        } catch {
            throw ClothingServiceError.decoding
        }
    }
}
