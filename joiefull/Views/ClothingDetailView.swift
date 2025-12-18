//
//  ClothingDetailView.swift
//  joiefull
//
//  Created by Julien Cotte on 18/12/2025.
//

import SwiftUI

struct ClothingDetailView: View {
    let clothing: Clothing

    var body: some View {
        ScrollView {
            AsyncImage(url: URL(string: clothing.picture.url)) { image in
                image.resizable().scaledToFit()
            } placeholder: {
                Color.gray.opacity(0.3)
            }

            VStack(alignment: .leading, spacing: 16) {
                Text(clothing.name)
                    .font(.title)
                    .bold()

                Text("\(clothing.price, specifier: "%.2f") €")
                    .font(.title2)

                HStack {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                    Text("\(clothing.likes)")
                }
            }
            .padding()
        }
        .navigationTitle(clothing.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}


#Preview {
    ClothingDetailView(clothing: .preview)
}
