//
//  ScorePill.swift
//  joiefull
//
//  Created by Julien Cotte on 18/12/2025.
//

import SwiftUI

struct ScorePill: View {
    let score: Double = 2.5

    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: "star.fill")
                .foregroundStyle(Color(.systemYellow))
            Text(String(format: "%0.1f", score))
                .foregroundStyle(.black)
                .font(.caption.weight(.semibold))
        }
    }
}

#Preview {
    ScorePill()
}
