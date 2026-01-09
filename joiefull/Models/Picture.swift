//
//  Picture.swift
//  joiefull
//
//  Created by Julien Cotte on 12/12/2025.
//

/// Represents an image with its URL and accessibility description
struct Picture: Decodable, Hashable {
    let url: String
    let description: String
}
