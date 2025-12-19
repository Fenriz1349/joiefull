//
//  ScoreLabel.swift
//  joiefull
//
//  Created by Julien Cotte on 18/12/2025.
//

import SwiftUI

struct ScoreLabel: View {
    let score: Double = 2.5

    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: "star.fill")
                .foregroundStyle(.orange)
            Text(String(format: "%0.1f", score))
                .fontWeight(.semibold)
        }
    }
}

#Preview {
    ScoreLabel()
}
