//
//  LikesPill.swift
//  joiefull
//
//  Created by Julien Cotte on 18/12/2025.
//

import SwiftUI

struct LikesPill: View {
    let likes: Int

    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: "heart")
            Text("\(likes)")
                .font(.caption.weight(.semibold))
        }
        .foregroundStyle(.black)
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .background(
            Capsule().fill(.white)
        )
    }
}

#Preview {
    LikesPill(likes: Clothing.preview.likes)
}
