//
//  ReviewInputView.swift
//  joiefull
//
//  Created by Julien Cotte on 18/12/2025.
//

import SwiftUI

struct ReviewInputView: View {
    @State private var text: String = ""

    var body: some View {
        ZStack(alignment: .topLeading) {

            if text.isEmpty {
                Text("Partagez ici vos impressions sur cette pièce")
                    .foregroundStyle(.gray)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
            }

            TextEditor(text: $text)
                .padding(12)
                .background(Color.clear)
                .scrollContentBackground(.hidden)
        }
        .frame(height: 120)
        .background(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.gray.opacity(0.4), lineWidth: 1)
        )
    }
}

#Preview {
    ReviewInputView()
}
