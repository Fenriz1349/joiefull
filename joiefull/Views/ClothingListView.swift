//
//  ClothingListView.swift
//  joiefull
//
//  Created by Julien Cotte on 18/12/2025.
//

import SwiftUI

struct ClothingListView: View {
    @StateObject private var viewModel = ClothingListViewModel()

    let selectedItem: Clothing?
    let onSelect: (Clothing) -> Void

    var body: some View {
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
                                    Button {
                                        onSelect(item)
                                    } label: {
                                        ClothingCardView(item: item,
                                                         isSelected: selectedItem?.id == item.id)
                                            .containerRelativeFrame(.horizontal, count: 3, spacing: 16)
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
        .task {
            await viewModel.load()
        }
    }
}

#Preview {
    ClothingListView(selectedItem: Clothing.preview, onSelect: {_ in })
}
