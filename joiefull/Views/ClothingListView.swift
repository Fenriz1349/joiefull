//
//  ClothingListView.swift
//  joiefull
//
//  Created by Julien Cotte on 18/12/2025.
//

import SwiftUI

struct ClothingListView: View {
    @StateObject private var viewModel = ClothingListViewModel()

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    ForEach(Category.allCases, id: \.self) { category in
                        VStack(alignment: .leading) {
                            Text(category.title)
                                .font(.title2)
                                .bold()
                                .padding(.horizontal)

                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack(spacing: 16) {
                                    ForEach(viewModel.clothes(for: category)) { item in
                                        NavigationLink(value: item) {
                                            ClothingCardView(item: item)
                                                .containerRelativeFrame(.horizontal, count: 2, spacing: 16)
                                        }
                                        .buttonStyle(.plain)
                                    }
                                }
                                .scrollTargetLayout()
                            }
                            .contentMargins(.horizontal, 16, for: .scrollContent)
                            .scrollTargetBehavior(.viewAligned)
                        }
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("Joyfull")
            .task {
                await viewModel.load()
            }
            .navigationDestination(for: Clothing.self) { item in
                ClothingDetailView(clothing: item)
            }
        }
    }
}

#Preview {
    ClothingListView()
}
